FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV KAFKA_VERSION=2.7.1
ENV KAFKA_FULL_VERSION=2.13-${KAFKA_VERSION}
ENV BASE_PATH=/opt
ENV KAFKA_HOME=$BASE_PATH/kafka

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

RUN echo "sh /opt/base.sh" >> /opt/start_zookeeper.sh
RUN echo "${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties" >> /opt/start_zookeeper.sh
RUN chmod 777 /opt/start_zookeeper.sh

ENTRYPOINT ["sh","-c","/opt/start_zookeeper.sh"]
