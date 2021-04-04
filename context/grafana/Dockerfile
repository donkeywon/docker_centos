FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV BASE_PATH=/opt
ENV GRAFANA_VERSION=7.5.2

RUN wget https://mirrors.huaweicloud.com/grafana/${GRAFANA_VERSION}/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz -O /tmp/1.tar.gz && \
    tar zxf /tmp/1.tar.gz -C ${BASE_PATH} && \
    rm -f /tmp/1.tar.gz && \
    ln -s ${BASE_PATH}/grafana-${GRAFANA_VERSION} ${BASE_PATH}/grafana && \
    cd ${BASE_PATH}/grafana && \
    mv conf conf.origin && \
    ln -s /shared/env/docker_centos/data/grafana/conf conf

RUN echo "sh /opt/base.sh" >> /opt/start_grafana.sh
RUN echo "cd ${BASE_PATH}/grafana && ./bin/grafana-server web" >> /opt/start_grafana.sh
RUN chmod 777 /opt/start_grafana.sh

ENTRYPOINT ["sh","-c","/opt/start_grafana.sh"]
