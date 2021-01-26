FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV BASE_PATH=/opt
ENV GOLANG_VERSION=1.15.7
ENV NODEJS_VERSION=14.15.4
ENV NODE_HOME=${BASE_PATH}/node
ENV GOROOT=${BASE_PATH}/go
ENV GOPATH=/root/workspace/gopath
ENV PATH=$GOROOT/bin:$NODE_HOME/bin:$PATH

RUN dnf groupinstall -y "Development Tools"
RUN dnf install -y python3-devel lua-devel luajit-devel perl-devel glibc-static vim-enhanced
# php build deps
RUN dnf install -y libzip-devel libxml2-devel systemtap-sdt-devel re2c openssl-devel bzip2-devel libcurl-devel libpng-devel gmp-devel libicu-devel aspell-devel readline-devel recode-devel libsodium-devel libxslt-devel libmemcached-devel libyaml-devel libevent-devel re2c net-snmp-devel libtidy-devel sqlite-devel libffi-devel libc-client-devel oniguruma-devel
# openresty build deps
RUN dnf install -y pcre-devel libpq-devel gd-devel perl-devel perl-ExtUtils-Embed geoip-devel gperftools-devel libatomic_ops-devel

RUN mv /etc/vimrc /etc/vimrc.origin && \
    ln -s /shared/env/docker_centos/data/vim/vimrc /etc/vimrc

RUN mkdir -p /root/workspace/src && \
    mkdir -p /root/workspace/gopath

#RUN dnf install -y golang
RUN mkdir -p ${BASE_PATH}/ && \
    wget https://studygolang.com/dl/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz -O /tmp/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    tar zxf /tmp/go${GOLANG_VERSION}.linux-amd64.tar.gz -C ${BASE_PATH}/ && \
    mv ${BASE_PATH}/go ${BASE_PATH}/go${GOLANG_VERSION} && \
    ln -s ${BASE_PATH}/go${GOLANG_VERSION} ${BASE_PATH}/go && \
    rm -f /tmp/go${GOLANG_VERSION}.linux-amd64.tar.gz

RUN wget https://npm.taobao.org/mirrors/node/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz -O /root/node-v${NODEJS_VERSION}-linux-x64.tar.gz && \
    tar zxf /root/node-v${NODEJS_VERSION}-linux-x64.tar.gz -C ${BASE_PATH} && \
    ln -s ${BASE_PATH}/node-v${NODEJS_VERSION}-linux-x64 ${NODE_HOME} && \
    rm -f /root/node-v${NODEJS_VERSION}-linux-x64.tar.gz && \
    echo "${NODE_HOME}/bin/npm config set registry https://registry.npm.taobao.org" > /root/set_npm_registry.sh

RUN echo "sh /opt/base.sh" >> /opt/start_build_base.sh
RUN echo "tail -f /dev/null" >> /opt/start_build_base.sh
RUN chmod 777 /opt/start_build_base.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_build_base.sh"]
