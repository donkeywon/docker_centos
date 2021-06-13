FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

RUN dnf install -y memcached && \
    dnf clean all && \
    rm -rf /var/cache/dnf/*

RUN echo "sh /opt/base.sh" >> /opt/start_memcached.sh
RUN echo "/usr/bin/memcached -m 64 -p 11211 -u memcached" >> /opt/start_memcached.sh
RUN chmod 777 /opt/start_memcached.sh

ENTRYPOINT ["sh","-c","/opt/start_memcached.sh"]
