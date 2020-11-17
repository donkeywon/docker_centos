FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV KIBANA_VERSION=6.8.13-linux-x86_64

RUN mkdir -p /usr/local/env && \
    wget https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}.tar.gz -O /tmp/kibana-${KIBANA_VERSION}.tar.gz && \
    tar zxf /tmp/kibana-${KIBANA_VERSION}.tar.gz -C /usr/local/env/ && \
    rm -f /tmp/kibana-${KIBANA_VERSION}.tar.gz && \
    ln -s /usr/local/env/kibana-${KIBANA_VERSION} /usr/local/env/kibana && \
    cd /usr/local/env/kibana && \
    mv config config.origin && \
    ln -s /shared/env/docker_centos/data/kibana/config config

RUN echo "sh /opt/base.sh" >> /opt/start_kibana.sh
RUN echo "sleep 5" >> /opt/start_kibana.sh
RUN echo "/usr/local/env/kibana/bin/kibana -c /usr/local/env/kibana/config/kibana.yml" >> /opt/start_kibana.sh
RUN chmod 777 /opt/start_kibana.sh

ENTRYPOINT ["sh","-c","/opt/start_kibana.sh"]
