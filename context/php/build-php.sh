PHP_VERSION=7.4.12
PHP_VERSION_FULL=${PHP_VERSION}
BASE_PATH=/usr/local/env
PHP_PATH=${BASE_PATH}/php-${PHP_VERSION_FULL}
PHP_BIN_PATH=${PHP_PATH}/bin
PHP_SRC_PATH=${PHP_PATH}/src

MSGPACK_VERSION=2.1.1
IGBINARY_VERSION=3.1.6
MEMCACHED_VERSION=3.1.5
REDIS_VERSION=5.3.2
EVENT_VERSION=2.5.7
YAC_VERSION=2.2.1
YAML_VERSION=2.1.0
ZEPHIR_PARSER_VERSION=v1.3.4
SWOOLE_VERSION=4.5.5
MONGODB_VERSION=1.8.1
GRPC_VERSION=1.33.1
PROTOBUF_VERSION=3.13.0.1
XDEBUG_VERSION=2.9.8

mkdir -p ${PHP_PATH}

cd ${PHP_PATH}
wget https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz
tar zxf php-${PHP_VERSION}.tar.gz
rm -f php-${PHP_VERSION}.tar.gz
mv php-${PHP_VERSION} src
cd src

./configure \
--prefix=${PHP_PATH} \
--sysconfdir=${PHP_PATH}/etc \
--with-libdir=lib64 \
--enable-fpm \
--with-fpm-user=root \
--with-fpm-group=root \
--enable-phpdbg \
--enable-phpdbg-webhelper \
--with-config-file-path=${PHP_PATH}/etc/php.ini \
--with-config-file-scan-dir=${PHP_PATH}/etc/conf.d \
--with-openssl=shared \
--with-pcre-jit \
--with-zlib \
--enable-bcmath=shared \
--with-bz2=shared \
--enable-calendar=shared \
--with-curl=shared \
--enable-dba=shared \
--enable-exif=shared \
--with-ffi=shared \
--enable-ftp=shared \
--enable-gd=shared \
--with-webp \
--with-jpeg \
--with-xpm \
--with-freetype \
--enable-gd-jis-conv \
--with-gettext=shared \
--with-gmp=shared \
--with-mhash=shared \
--with-imap=shared \
--with-kerberos \
--with-imap-ssl \
--enable-intl=shared \
--enable-mbstring=shared \
--with-mysqli=mysqlnd \
--enable-pcntl=shared \
--with-pdo-mysql=shared \
--with-pdo-pgsql=shared \
--with-pspell=shared \
--with-readline=shared \
--enable-shmop=shared \
--with-snmp=shared \
--enable-soap=shared \
--enable-sockets=shared \
--with-sodium=shared \
--enable-sysvmsg=shared \
--enable-sysvsem=shared \
--enable-sysvshm=shared \
--with-tidy=shared \
--with-xmlrpc=shared \
--with-xsl=shared \
--with-zip=shared \
--enable-mysqlnd \
CFLAGS="-Os" \
CXXFLAGS="-Os"

make -j8
make install
make distclean

cp php.ini-development ${PHP_PATH}/etc/php.ini
cd ${PHP_PATH}/etc
sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/' php.ini

cp php-fpm.conf.default php-fpm.conf
sed -i 's/;pid =/pid =/' php-fpm.conf
sed -i 's/;error_log =/error_log =/' php-fpm.conf
sed -i 's/;log_level =/log_level =/' php-fpm.conf

cd php-fpm.d
cp www.conf.default www.conf
sed -i 's/;pm.status_path = \/status/pm.status_path = \/php-status/' www.conf
sed -i 's/;ping.path = \/ping/ping.path = \/php-ping/' www.conf
sed -i 's/;access.log = log\/$pool.access.log/access.log = var\/log\/$pool.access.log/' www.conf
sed -i 's/;access.format/access.format/' www.conf
sed -i 's/;slowlog = log/slowlog = var\/log/' www.conf

mkdir -p ${PHP_PATH}/etc/conf.d
cd ${PHP_PATH}/etc/conf.d
echo "extension=bcmath.so" > bcmath.ini
echo "extension=bz2.so" > bz2.ini
echo "extension=calendar.so" > calendar.ini
echo "extension=curl.so" > curl.ini
echo "extension=dba.so" > dba.ini
echo "extension=exif.so" > exif.ini
echo "extension=ffi.so" > ffi.ini
echo "extension=ftp.so" > ftp.ini
echo "extension=gd.so" > gd.ini
echo "extension=pdo_mysql.so" > pdo_mysql.ini
echo "extension=pdo_pgsql.so" > pdo_pgsql.ini
echo "extension=gettext.so" > gettext.ini
echo "extension=intl.so" > intl.ini
echo ";extension=ldap.so" > ldap.ini
echo "extension=mbstring.so" > mbstring.ini
echo "extension=openssl.so" > openssl.ini
echo "extension=pcntl.so" > pcntl.ini
echo "extension=pspell.so" > pspell.ini
echo "extension=soap.so" > soap.ini
echo "extension=sockets.so" > sockets.ini
echo "extension=sodium.so" > sodium.ini
echo "extension=readline.so" > readline.ini
echo "extension=xsl.so" > xsl.ini
echo "extension=gmp.so" > gmp.ini
echo "extension=shmop.so" > shmop.ini
echo "extension=snmp.so" > snmp.ini
echo "extension=xmlrpc.so" > xmlrpc.ini
echo "extension=zip.so" > zip.ini
echo "extension=tidy.so" > tidy.ini
echo "extension=sysvmsg.so" > sysvmsg.ini
echo "extension=sysvsem.so" > sysvsem.ini
echo "extension=sysvshm.so" > sysvshm.ini
cat > opcache.ini <<EOF
zend_extension=opcache.so
opcache.enable=0
opcache.enable_cli=0
opcache.enable_file_override=1
opcache.memory_consumption=256
opcache.max_accelerated_files=16229
opcache.validate_timestamps=0
opcache.revalidate_freq=60
opcache.fast_shutdown=1
opcache.force_restart_timeout=30
EOF

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/msgpack-${MSGPACK_VERSION}.tgz
tar zxf msgpack-${MSGPACK_VERSION}.tgz
rm -f msgpack-${MSGPACK_VERSION}.tgz
cd msgpack-${MSGPACK_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --with-msgpack CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=msgpack.so" > ${PHP_PATH}/etc/conf.d/msgpack.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/igbinary-${IGBINARY_VERSION}.tgz
tar zxf igbinary-${IGBINARY_VERSION}.tgz
rm -f igbinary-${IGBINARY_VERSION}.tgz
cd igbinary-${IGBINARY_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-igbinary CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=igbinary.so" > ${PHP_PATH}/etc/conf.d/igbinary.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/memcached-${MEMCACHED_VERSION}.tgz
tar zxf memcached-${MEMCACHED_VERSION}.tgz
rm -f memcached-${MEMCACHED_VERSION}.tgz
cd memcached-${MEMCACHED_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-memcached-igbinary --enable-memcached-json --enable-memcached-msgpack --disable-memcached-sasl CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=memcached.so" > ${PHP_PATH}/etc/conf.d/memcached.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/redis-${REDIS_VERSION}.tgz
tar zxf redis-${REDIS_VERSION}.tgz
rm -f redis-${REDIS_VERSION}.tgz
cd redis-${REDIS_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-redis --enable-redis-igbinary --enable-redis-msgpack CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=redis.so" > ${PHP_PATH}/etc/conf.d/redis.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/event-${EVENT_VERSION}.tgz
tar zxf event-${EVENT_VERSION}.tgz
rm -f event-${EVENT_VERSION}.tgz
cd event-${EVENT_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --with-event-core --with-event-extra --with-event-openssl --enable-event-sockets CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=event.so" >> ${PHP_PATH}/etc/conf.d/sockets.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/swoole-${SWOOLE_VERSION}.tgz
tar zxf swoole-${SWOOLE_VERSION}.tgz
rm -f swoole-${SWOOLE_VERSION}.tgz
cd swoole-${SWOOLE_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-sockets --enable-openssl --with-openssl-dir=/usr --enable-http2 --enable-swoole --enable-mysqlnd CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=swoole.so" >> ${PHP_PATH}/etc/conf.d/swoole.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/yac-${YAC_VERSION}.tgz
tar zxf yac-${YAC_VERSION}.tgz
rm -f yac-${YAC_VERSION}.tgz
cd yac-${YAC_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-yac CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=yac.so" > ${PHP_PATH}/etc/conf.d/yac.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/mongodb-${MONGODB_VERSION}.tgz
tar zxf mongodb-${MONGODB_VERSION}.tgz
rm -f mongodb-${MONGODB_VERSION}.tgz
cd mongodb-${MONGODB_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-mongodb CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=mongodb.so" > ${PHP_PATH}/etc/conf.d/mongodb.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/yaml-${YAML_VERSION}.tgz
tar zxf yaml-${YAML_VERSION}.tgz
rm -f yaml-${YAML_VERSION}.tgz
cd yaml-${YAML_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --with-yaml CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=yaml.so" > ${PHP_PATH}/etc/conf.d/yaml.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/protobuf-${PROTOBUF_VERSION}.tgz
tar zxf protobuf-${PROTOBUF_VERSION}.tgz
rm -f protobuf-${PROTOBUF_VERSION}.tgz
cd protobuf-${PROTOBUF_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-protobuf CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=protobuf.so" > ${PHP_PATH}/etc/conf.d/protobuf.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/grpc-${GRPC_VERSION}.tgz
tar zxf grpc-${GRPC_VERSION}.tgz
rm -f grpc-${GRPC_VERSION}.tgz
cd grpc-${GRPC_VERSION}
sed -i "s/-g -O2/-s -Os/g" config.m4
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-grpc CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=grpc.so" > ${PHP_PATH}/etc/conf.d/grpc.ini

cd ${PHP_SRC_PATH}/ext
git clone https://github.com/phalcon/php-zephir-parser.git
cd php-zephir-parser
git checkout ${ZEPHIR_PARSER_VERSION}
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-zephir-parser CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
echo "extension=zephir_parser.so" > ${PHP_PATH}/etc/conf.d/zephir_parser.ini

cd ${PHP_SRC_PATH}/ext
wget http://pecl.php.net/get/xdebug-${XDEBUG_VERSION}.tgz
tar zxf xdebug-${XDEBUG_VERSION}.tgz
rm -f xdebug-${XDEBUG_VERSION}.tgz
cd xdebug-${XDEBUG_VERSION}
sed -i "s/-g -O2/-s -Os/g" config.m4
${PHP_BIN_PATH}/phpize
./configure --with-php-config=${PHP_BIN_PATH}/php-config --enable-xdebug CFLAGS="-Os" CXXFLAGS="-Os"
make -j8
make install
make distclean
cat > ${PHP_PATH}/etc/conf.d/xdebug.ini <<EOF
zend_extension=xdebug.so

xdebug.remote_enable=1
xdebug.remote_autostart=1
xdebug.remote_host=host.docker.internal
EOF

rm -rf ${PHP_PATH}/src

cd ${BASE_PATH}
tar -Jcpf php-${PHP_VERSION_FULL}.tar.xz php-${PHP_VERSION_FULL}
mv php-${PHP_VERSION_FULL}.tar.xz /root/
