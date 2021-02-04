FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV BASE_PATH=/opt
ENV KIBANA_HOME=$BASE_PATH/kibana
ENV KIBANA_VERSION=7.10.2
ENV KIBANA_VERSION_FULL=${KIBANA_VERSION}-linux-x86_64

RUN wget https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION_FULL}.tar.gz -O /tmp/kibana-${KIBANA_VERSION_FULL}.tar.gz && \
    tar zxf /tmp/kibana-${KIBANA_VERSION_FULL}.tar.gz -C ${BASE_PATH} && \
    rm -f /tmp/kibana-${KIBANA_VERSION_FULL}.tar.gz && \
    ln -s ${BASE_PATH}/kibana-${KIBANA_VERSION_FULL} ${KIBANA_HOME} && \
    cd ${KIBANA_HOME} && \
    mv config config.origin && \
    ln -s /shared/env/docker_centos/data/kibana/config config

RUN echo "sh /opt/base.sh" >> /opt/start_kibana.sh
RUN echo "sleep 5" >> /opt/start_kibana.sh
RUN echo "${KIBANA_HOME}/bin/kibana -c ${KIBANA_HOME}/config/kibana.yml --allow-root" >> /opt/start_kibana.sh
RUN chmod 777 /opt/start_kibana.sh

ENTRYPOINT ["sh","-c","/opt/start_kibana.sh"]
