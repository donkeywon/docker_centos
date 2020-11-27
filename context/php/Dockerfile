FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

RUN dnf install -y libpng libicu libmemcached aspell recode libsodium libxslt libyaml libnghttp2 graphviz librdkafka libzip libtidy net-snmp oniguruma libpq

ENV BASE_PATH=/opt
ENV PHP_VERSION=7.4.13
ENV PHP_HOME=$BASE_PATH/php
ENV PHP_IDE_CONFIG="serverName=localhost"
ENV PATH=$PHP_HOME/bin:$PATH

COPY php-${PHP_VERSION}.tar.xz ${BASE_PATH}
RUN tar Jxf ${BASE_PATH}/php-${PHP_VERSION}.tar.xz -C ${BASE_PATH} \
    && rm -f ${BASE_PATH}/php-${PHP_VERSION}.tar.xz \
    && ln -s ${BASE_PATH}/php-${PHP_VERSION} ${PHP_HOME}

RUN echo "sh /opt/base.sh" >> /opt/start_php.sh
RUN echo "${PHP_HOME}/sbin/php-fpm --nodaemonize -R --fpm-config ${PHP_HOME}/etc/php-fpm.conf" >> /opt/start_php.sh
RUN chmod 777 /opt/start_php.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_php.sh"]
