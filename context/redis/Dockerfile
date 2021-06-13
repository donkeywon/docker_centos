FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

RUN dnf install -y redis && \
    dnf clean all && \
    rm -rf /var/cache/dnf/*

RUN echo "sh /opt/base.sh" >> /opt/start_redis.sh
RUN echo "/usr/bin/redis-server /shared/env/docker_centos/data/redis/redis.conf" >> /opt/start_redis.sh
RUN chmod 777 /opt/start_redis.sh

ENTRYPOINT ["sh","-c","/opt/start_redis.sh"]
