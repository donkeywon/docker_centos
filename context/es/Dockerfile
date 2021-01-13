FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV ES_VERSION=6.8.13
ENV BASE_PATH=/opt
ENV ES_HOME=$BASE_PATH/elasticsearch

RUN dnf install -y java-latest-openjdk sudo

RUN useradd elasticsearch

RUN wget https://mirrors.huaweicloud.com/elasticsearch/${ES_VERSION}/elasticsearch-${ES_VERSION}.tar.gz -O /tmp/elasticsearch-${ES_VERSION}.tar.gz && \
    tar zxf /tmp/elasticsearch-${ES_VERSION}.tar.gz -C ${BASE_PATH} && \
    rm -f /tmp/elasticsearch-${ES_VERSION}.tar.gz && \
    ln -s /opt/elasticsearch-${ES_VERSION} ${ES_HOME} && \
    cd ${ES_HOME} && \
    mv config config.origin && \
    ln -s /shared/env/docker_centos/data/es/node1/config config && \
    chown -R elasticsearch:elasticsearch ${ES_HOME} && \
    chown -R elasticsearch:elasticsearch ${BASE_PATH}/elasticsearch-${ES_VERSION}

RUN echo "sh /opt/base.sh" >> /opt/start_es_node1.sh
RUN echo "chmod 777 -R /shared/env/docker_centos/data/es" >> /opt/start_es_node1.sh
RUN echo "sudo -u elasticsearch ${ES_HOME}/bin/elasticsearch" >> /opt/start_es_node1.sh
RUN chmod 777 /opt/start_es_node1.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_es_node1.sh"]
