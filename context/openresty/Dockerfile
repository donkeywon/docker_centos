FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV BASE_PATH=/opt
ENV OPENRESTY_HOME=$BASE_PATH/openresty
ENV OPENRESTY_VERSION=1.19.3.2

RUN dnf install -y libpq libatomic_ops libxslt gd geoip gperftools-libs perl

COPY openresty-${OPENRESTY_VERSION}.tar.xz ${BASE_PATH}
RUN tar Jxpf ${BASE_PATH}/openresty-${OPENRESTY_VERSION}.tar.xz -C ${BASE_PATH} \
    && rm -f ${BASE_PATH}/openresty-${OPENRESTY_VERSION}.tar.xz \
    && ln -s ${BASE_PATH}/openresty-${OPENRESTY_VERSION} ${OPENRESTY_HOME} \
    && cp -r ${OPENRESTY_HOME}/perl5 /usr/local/lib64/ \
    && ln -s ${OPENRESTY_HOME}/bin/openresty /usr/local/bin/openresty

RUN echo "sh /opt/base.sh" >> /opt/start_openresty.sh
RUN echo "${OPENRESTY_HOME}/bin/openresty" >> /opt/start_openresty.sh
RUN echo "tail -f /dev/null" >> /opt/start_openresty.sh
RUN chmod 777 /opt/start_openresty.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_openresty.sh"]
