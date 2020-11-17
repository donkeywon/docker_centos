FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV KAFKA_VERSION=2.6.0
ENV KAFKA_FULL_VERSION=2.13-2.6.0

RUN dnf install -y java-latest-openjdk

RUN mkdir -p /usr/local/env \
    && wget https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${KAFKA_FULL_VERSION}.tgz -O /tmp/kafka_${KAFKA_FULL_VERSION}.tgz \
    && tar zxf /tmp/kafka_${KAFKA_FULL_VERSION}.tgz -C /usr/local/env/ \
    && rm -f /tmp/kafka_${KAFKA_FULL_VERSION}.tgz \
    && ln -s /usr/local/env/kafka_${KAFKA_FULL_VERSION} /usr/local/env/kafka \
    && cd /usr/local/env/kafka \
    && mv config config.origin \
    && ln -s /shared/env/docker_centos/data/kafka/config config \
    && sed -i 's/1G/256M/g' /usr/local/env/kafka/bin/kafka-server-start.sh \
    && sed -i 's/512M/64M/g' /usr/local/env/kafka/bin/zookeeper-server-start.sh

RUN echo "sh /opt/base.sh" >> /opt/start_zookeeper.sh
RUN echo "/usr/local/env/kafka/bin/zookeeper-server-start.sh /usr/local/env/kafka/config/zookeeper.properties" >> /opt/start_zookeeper.sh
RUN chmod 777 /opt/start_zookeeper.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_zookeeper.sh"]
