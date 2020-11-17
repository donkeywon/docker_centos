FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV GRAFANA_VERSION=7.3.2

RUN mkdir -p /usr/local/env && \
    wget https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz -O /tmp/1.tar.gz && \
    tar zxf /tmp/1.tar.gz -C /usr/local/env/ && \
    rm -f /tmp/1.tar.gz && \
    ln -s /usr/local/env/grafana-${GRAFANA_VERSION} /usr/local/env/grafana && \
    cd /usr/local/env/grafana && \
    mv conf conf.origin && \
    ln -s /shared/env/docker_centos/data/grafana/conf conf

RUN echo "sh /opt/base.sh" >> /opt/start_grafana.sh
RUN echo "cd /usr/local/env/grafana && ./bin/grafana-server web" >> /opt/start_grafana.sh
RUN chmod 777 /opt/start_grafana.sh

ENTRYPOINT ["sh","-c","/opt/start_grafana.sh"]
