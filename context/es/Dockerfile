FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV ES_VERSION=6.8.13
RUN dnf install -y java-latest-openjdk sudo

RUN useradd elasticsearch

RUN mkdir -p /usr/local/env \
    && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz -O /tmp/elasticsearch-${ES_VERSION}.tar.gz \
    && tar zxf /tmp/elasticsearch-${ES_VERSION}.tar.gz -C /usr/local/env/ \
    && rm -f /tmp/elasticsearch-${ES_VERSION}.tar.gz \
    && ln -s /usr/local/env/elasticsearch-${ES_VERSION} /usr/local/env/elasticsearch \
    && cd /usr/local/env/elasticsearch \
    && mv config config.origin \
    && ln -s /shared/env/docker_centos/data/es/node1/config config \
    && chown -R elasticsearch:elasticsearch /usr/local/env/elasticsearch-${ES_VERSION} \
    && chown -R elasticsearch:elasticsearch /usr/local/env/elasticsearch \
    && mkdir /var/log/elasticsearch \
    && chown -R elasticsearch:elasticsearch /var/log/elasticsearch

RUN echo "sh /opt/base.sh" >> /opt/start_es_node1.sh
RUN echo "chmod 777 -R /shared/env/data/docker_centos/es" >> /opt/start_es_node1.sh
RUN echo "sudo -u elasticsearch /usr/local/env/elasticsearch/bin/elasticsearch" >> /opt/start_es_node1.sh
RUN chmod 777 /opt/start_es_node1.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_es_node1.sh"]
