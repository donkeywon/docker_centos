FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV INFLUXDB_VERSION=1.8.3

RUN mkdir -p /usr/local/env/ \
    && wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz -O /tmp/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz \
    && tar zxf /tmp/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz -C /usr/local/env/ \
    && rm -f /tmp/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz \
    && ln -s /usr/local/env/influxdb-${INFLUXDB_VERSION}-1 /usr/local/env/influxdb \
    && rm -rf /usr/local/env/influxdb/usr \
    && ln -s /usr/local/env/influxdb/* /usr/local/bin/

RUN echo "sh /opt/base.sh" >> /opt/start_influxdb.sh
RUN echo "/usr/local/env/influxdb/influxd run -config /shared/env/docker_centos/data/influxdb/influxdb.conf" >> /opt/start_influxdb.sh
RUN chmod 777 /opt/start_influxdb.sh

ENTRYPOINT ["sh","-c","/opt/start_influxdb.sh"]
