FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV ES_VERSION=7.11.1
ENV ES_VERSION_FULL=${ES_VERSION}-linux-x86_64

ENV BASE_PATH=/opt
ENV ES_HOME=$BASE_PATH/elasticsearch
ENV JAVA_HOME=$ES_HOME/jdk
ENV PATH=$JAVA_HOME/bin:$PATH

RUN useradd elasticsearch

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION_FULL}.tar.gz -O /tmp/elasticsearch-${ES_VERSION_FULL}.tar.gz && \
    tar zxf /tmp/elasticsearch-${ES_VERSION_FULL}.tar.gz -C ${BASE_PATH} && \
    rm -f /tmp/elasticsearch-${ES_VERSION_FULL}.tar.gz && \
    ln -s /opt/elasticsearch-${ES_VERSION} ${ES_HOME} && \
    cd ${ES_HOME} && \
    mv config config.origin && \
    ln -s /shared/env/docker_centos/data/es/config config && \
    chown -R elasticsearch:elasticsearch ${ES_HOME} && \
    chown -R elasticsearch:elasticsearch ${BASE_PATH}/elasticsearch-${ES_VERSION}

RUN echo "sh /opt/base.sh" >> /opt/start_es.sh
RUN echo "chmod 777 -R /shared/env/docker_centos/data/es" >> /opt/start_es.sh
RUN echo "exec chroot --userspec=elasticsearch:elasticsearch / ${ES_HOME}/bin/elasticsearch" >> /opt/start_es.sh
RUN echo "tail -f /dev/null" >> /opt/start_es.sh
RUN chmod 777 /opt/start_es.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_es.sh"]
