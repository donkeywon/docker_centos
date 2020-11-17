FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

RUN dnf install -y libpng libicu libmemcached aspell recode libsodium libxslt libyaml libnghttp2 graphviz librdkafka libzip libtidy net-snmp oniguruma

ENV PHP_VERSION=7.4.12
RUN mkdir -p /usr/local/env
COPY php-${PHP_VERSION}.tar.xz /usr/local/env/
RUN tar Jxf /usr/local/env/php-${PHP_VERSION}.tar.xz -C /usr/local/env/ \
    && rm -f /usr/local/env/php-${PHP_VERSION}.tar.xz \
    && ln -s /usr/local/env/php-${PHP_VERSION} /usr/local/env/php

RUN echo 'export PHP_IDE_CONFIG="serverName=dkw-dev.com"' >> /etc/profile.d/php.sh
RUN echo 'export PHP_HOME=/usr/local/env/php' >> /etc/profile.d/php.sh
RUN echo 'export PATH=$PHP_HOME/bin:$PATH' >> /etc/profile.d/php.sh

RUN echo "sh /opt/base.sh" >> /opt/start_php.sh
RUN echo "/usr/local/env/php/sbin/php-fpm --nodaemonize -R --fpm-config /usr/local/env/php/etc/php-fpm.conf" >> /opt/start_php.sh
RUN chmod 777 /opt/start_php.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_php.sh"]
