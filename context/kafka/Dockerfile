FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV BASE_PATH=/opt
ENV KAFKA_HOME=$BASE_PATH/kafka
ENV KAFKA_VERSION=2.7.1
ENV KAFKA_FULL_VERSION=2.13-$KAFKA_VERSION

RUN dnf install -y java-latest-openjdk && \
    dnf clean all && \
    rm -rf /var/cache/dnf/*

RUN wget https://mirrors.huaweicloud.com/apache/kafka/${KAFKA_VERSION}/kafka_${KAFKA_FULL_VERSION}.tgz -O /tmp/kafka_${KAFKA_FULL_VERSION}.tgz && \
    tar zxf /tmp/kafka_${KAFKA_FULL_VERSION}.tgz -C ${BASE_PATH} && \
    rm -f /tmp/kafka_${KAFKA_FULL_VERSION}.tgz && \
    ln -s ${BASE_PATH}/kafka_${KAFKA_FULL_VERSION} ${KAFKA_HOME} && \
    cd ${KAFKA_HOME} && \
    mv config config.origin && \
    ln -s /shared/env/docker_centos/data/kafka/config config && \
    sed -i 's/1G/256M/g' ${KAFKA_HOME}/bin/kafka-server-start.sh && \
    sed -i 's/512M/64M/g' ${KAFKA_HOME}/bin/zookeeper-server-start.sh

RUN echo "${KAFKA_HOME}/bin/kafka-console-consumer.sh --bootstrap-server 172.19.0.20:9092 --topic \$1" > /root/console_consumer.sh && \
    chmod +x /root/console_consumer.sh
RUN echo "${KAFKA_HOME}/bin/kafka-console-producer.sh --broker-list 172.19.0.20:9092 --topic \$1" > /root/console_producer.sh && \
    chmod +x /root/console_producer.sh
RUN echo "${KAFKA_HOME}/bin/kafka-topics.sh --bootstrap-server 172.19.0.20:9092 --create --partitions 1 --replication-factor 1 --topic \$1" > /root/create_topic.sh && \
    chmod +x /root/create_topic.sh

RUN echo "sh /opt/base.sh" >> /opt/start_kafka.sh
# wait zookeeper
RUN echo "sleep 3" >> /opt/start_kafka.sh
RUN echo "${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties" >> /opt/start_kafka.sh
RUN chmod 777 /opt/start_kafka.sh

ENTRYPOINT ["sh","-c","/opt/start_kafka.sh"]
