OPENRESTY_VERSION=1.19.3.1
OPENRESTY_VERSION_FULL=${OPENRESTY_VERSION}
BASE_PATH=/opt
OPENRESTY_PATH=${BASE_PATH}/openresty-${OPENRESTY_VERSION_FULL}

if [[ $1 = "dev" ]]; then
    CFLAGS="-g -O2"
    CXXFLAGS="-g -O2"
else
    CFLAGS="-Os"
    CXXFLAGS="-Os"
fi

mkdir -p ${OPENRESTY_PATH}
cd ${OPENRESTY_PATH}
wget https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz
tar zxf openresty-${OPENRESTY_VERSION}.tar.gz
rm -f openresty-${OPENRESTY_VERSION}.tar.gz
mv openresty-${OPENRESTY_VERSION} src
cd src

./configure \
--prefix=${OPENRESTY_PATH} \
--with-cc-opt="${CFLAGS} -DNGX_LUA_ABORT_AT_PANIC" \
-j8 \
--with-http_iconv_module \
--with-http_postgres_module \
--with-luajit-xcflags="${CFLAGS}" \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module=dynamic \
--with-http_image_filter_module=dynamic \
--with-http_geoip_module=dynamic \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_degradation_module \
--with-http_slice_module \
--with-http_stub_status_module \
--with-http_perl_module=dynamic \
--with-mail=dynamic \
--with-mail_ssl_module \
--with-stream=dynamic \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_geoip_module=dynamic \
--with-stream_ssl_preread_module \
--with-google_perftools_module \
--with-cpp_test_module \
--with-compat \
--with-pcre \
--with-pcre-jit \
--with-libatomic \
--pid-path=${OPENRESTY_PATH}/nginx/var/nginx.pid \
--lock-path=${OPENRESTY_PATH}/nginx/var/openresty.lock

make -j4
make install
cp -r /usr/local/lib64/perl5 ${OPENRESTY_PATH}/
make clean

if [[ $1 != "dev" ]]; then
    cd ${OPENRESTY_PATH} && rm -rf src && find . -name '*' | xargs strip
fi

mkdir ${OPENRESTY_PATH}/luascript

cat > ${OPENRESTY_PATH}/nginx/conf/fastcgi-php.conf <<"EOF"
fastcgi_split_path_info ^(.+\.php)(/.+)$;
try_files $fastcgi_script_name =404;
set $path_info $fastcgi_path_info;
fastcgi_param PATH_INFO $path_info;
fastcgi_index index.php;
include fastcgi.conf;
EOF

cat > ${OPENRESTY_PATH}/nginx/conf/lua.conf <<"EOF"
lua_package_path '/opt/openresty/luascript/?.lua;/opt/openresty/lualib/?.lua;';
lua_package_cpath '/opt/openresty/lualib/?.so;';
lua_shared_dict count 1M;
lua_shared_dict turl_map 100k;
lua_shared_dict turl_hit 100k;
lua_shared_dict sys_level 16k;
lua_shared_dict ops_hds_iplist 64k;
lua_shared_dict ops_hds_report 128k;
EOF

mv ${OPENRESTY_PATH}/nginx/conf/nginx.conf ${OPENRESTY_PATH}/nginx/conf/nginx.conf.origin
cat > ${OPENRESTY_PATH}/nginx/conf/nginx.conf <<"EOF"
load_module modules/ngx_http_perl_module.so;
load_module modules/ngx_http_geoip_module.so;
load_module modules/ngx_http_image_filter_module.so;
load_module modules/ngx_http_xslt_filter_module.so;
load_module modules/ngx_mail_module.so;
load_module modules/ngx_stream_geoip_module.so;

user root;
worker_processes auto;
worker_cpu_affinity auto;
worker_rlimit_nofile 102400;
error_log logs/error.log;
pid var/nginx.pid;

events {
    use epoll;
    accept_mutex off;
    worker_connections 102400;
}

http {
    include mime.types;
    default_type application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] $hostname "$request" '
                      '$status $body_bytes_sent $request_time "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  logs/access.log  main;
    #acess_log /dev/null;

    sendfile        on;
    tcp_nopush      on;
    tcp_nodelay     on;

    keepalive_timeout  30;
    types_hash_max_size 2048;
    proxy_connect_timeout 300;
    proxy_read_timeout 300;
    proxy_send_timeout 300;

    fastcgi_connect_timeout 15;
    fastcgi_send_timeout 150;
    fastcgi_read_timeout 150;
    fastcgi_buffer_size 32k;
    fastcgi_buffers 4 32k;
    fastcgi_busy_buffers_size 64k;
    fastcgi_temp_file_write_size 64k;

    open_file_cache max=102400 inactive=20s;
    open_file_cache_valid 30s;
    open_file_cache_min_uses 1;

    server_names_hash_bucket_size 128;
    client_header_buffer_size 64k;
    large_client_header_buffers 4 128k;
    client_max_body_size 8m;
    client_body_timeout 3m;
    client_header_timeout 3m;

    gzip on;
    gzip_disable "MSIE [1-6]\.";
    gzip_comp_level 3;
    gzip_buffers 4 8k;
    gzip_min_length 1000;
    gzip_types text/plain text/css application/x-javascript text/javascript application/json;

    include lua.conf;
    include sites-enabled/*.conf;
}
EOF

mkdir ${OPENRESTY_PATH}/nginx/conf/sites-enabled
mkdir ${OPENRESTY_PATH}/nginx/conf/sites-available
cat > ${OPENRESTY_PATH}/nginx/conf/sites-available/default.conf <<"EOF"
server {
    listen          80;
    server_name     localhost;
    server_tokens   off;
    root            /shared/code/web;
    index           index.php index.html;

    #log_by_lua_file ../luascript/accesslog_to_remote.lua;

    location  /php-status {
        include fastcgi_params;
        fastcgi_pass 172.19.0.3:9000;
        fastcgi_param SCRIPT_FILENAME $fastcgi_script_name;
        allow 127.0.0.1;
        deny all;
    }

    location ~* \.php {
        proxy_buffer_size 64k;
        proxy_buffers 32 32k;
        proxy_busy_buffers_size 128k;
        fastcgi_pass 172.19.0.3:9000;
        include fastcgi-php.conf;
    }
}
EOF

cd ${BASE_PATH}
tar -Jcpf openresty-${OPENRESTY_VERSION_FULL}.tar.xz openresty-${OPENRESTY_VERSION_FULL}
mv openresty-${OPENRESTY_VERSION_FULL}.tar.xz /root/
