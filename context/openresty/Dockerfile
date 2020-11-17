FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

RUN dnf install -y libpq libatomic_ops libxslt gd geoip gperftools-libs perl

ENV OPENRESTY_VERSION=1.19.3.1

RUN mkdir -p /usr/local/env
COPY openresty-${OPENRESTY_VERSION}.tar.xz /usr/local/env/
RUN tar Jxpf /usr/local/env/openresty-${OPENRESTY_VERSION}.tar.xz -C /usr/local/env/ \
    && rm -f /usr/local/env/openresty-${OPENRESTY_VERSION}.tar.xz \
    && ln -s /usr/local/env/openresty-${OPENRESTY_VERSION} /usr/local/env/openresty \
    && cp -r /usr/local/env/openresty/perl5 /usr/local/lib64/ \
    && ln -s /usr/local/env/openresty/bin/openresty /usr/local/bin/openresty

RUN echo "sh /opt/base.sh" >> /opt/start_openresty.sh
RUN echo "/usr/local/env/openresty/bin/openresty" >> /opt/start_openresty.sh
RUN echo "tail -f /dev/null" >> /opt/start_openresty.sh
RUN chmod 777 /opt/start_openresty.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_openresty.sh"]
