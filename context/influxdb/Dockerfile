FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV BASE_PATH=/opt
ENV INFLUXDB_HOME=$BASE_PATH/influxdb
ENV INFLUXDB_VERSION=1.8.5
ENV PATH=$INFLUXDB_HOME:$PATH

RUN wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz -O /tmp/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz && \
    tar zxf /tmp/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz -C ${BASE_PATH} && \
    rm -f /tmp/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz && \
    ln -s ${BASE_PATH}/influxdb-${INFLUXDB_VERSION}-1 ${BASE_PATH}/influxdb && \
    rm -rf ${BASE_PATH}/influxdb/usr

RUN echo "sh /opt/base.sh" >> /opt/start_influxdb.sh
RUN echo "${INFLUXDB_HOME}/influxd run -config /shared/env/docker_centos/data/influxdb/influxdb.conf" >> /opt/start_influxdb.sh
RUN chmod 777 /opt/start_influxdb.sh

ENTRYPOINT ["sh","-c","/opt/start_influxdb.sh"]
