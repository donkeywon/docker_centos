FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV YAPI_VERSION=1.9.2
ENV NODEJS_VERSION=14.15.1
ENV BASE_PATH=/opt
ENV YAPI_PATH=$BASE_PATH/yapi
ENV NODE_HOME=$BASE_PATH/node
ENV PATH=$NODE_HOME/bin:$PATH

RUN wget https://npm.taobao.org/mirrors/node/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz -O /root/node-v${NODEJS_VERSION}-linux-x64.tar.gz && \
    tar zxf /root/node-v${NODEJS_VERSION}-linux-x64.tar.gz -C ${BASE_PATH} && \
    ln -s ${BASE_PATH}/node-v${NODEJS_VERSION}-linux-x64 ${NODE_HOME} && \
    rm -f /root/node-v${NODEJS_VERSION}-linux-x64.tar.gz

RUN mkdir -p ${YAPI_PATH} && \
    wget https://github.com/YMFE/yapi/archive/v${YAPI_VERSION}.tar.gz -O ${YAPI_PATH}/yapi.tar.gz && \
    cd ${YAPI_PATH} && \
    tar zxf yapi.tar.gz && \
    rm -f yapi.tar.gz && \
    mv yapi-${YAPI_VERSION} vendors && \
    cd vendors && \
    ${NODE_HOME}/bin/node ${NODE_HOME}/bin/npm i --production --unsafe-perm --registry https://registry.npm.taobao.org && \
    ln -s /shared/env/docker_centos/data/yapi/config.json ${YAPI_PATH}/config.json

RUN echo "${NODE_HOME}/bin/npm config set registry https://registry.npm.taobao.org" > /root/set_npm_registry.sh

RUN echo "sh /opt/base.sh" >> /opt/start_yapi.sh
RUN echo "${NODE_HOME}/bin/node ${YAPI_PATH}/vendors/server/app.js" >> /opt/start_yapi.sh
RUN chmod 777 /opt/start_yapi.sh

ENTRYPOINT ["sh","-c","/opt/start_yapi.sh"]
