FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

ENV GITEA_VERSION=1.14.1
ENV GIT_VERSION=2.29.2
ENV BASE_PATH=/opt
ENV GIT_HOME=$BASE_PATH/git
ENV PATH=$GIT_HOME/bin:$PATH

COPY git-${GIT_VERSION}.tar.xz /tmp/
RUN tar Jxf /tmp/git-${GIT_VERSION}.tar.xz -C ${BASE_PATH} && \
    rm -f /tmp/git-${GIT_VERSION}.tar.xz && \
    ln -s ${BASE_PATH}/git-${GIT_VERSION} ${BASE_PATH}/git && \
    ln -s ${GIT_HOME}/bin/* /usr/local/bin/

RUN mkdir -p ${BASE_PATH}/gitea && cd ${BASE_PATH}/gitea && \
    wget https://github.com/go-gitea/gitea/releases/download/v${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-amd64 && \
    chmod +x gitea-${GITEA_VERSION}-linux-amd64 && \
    ln -s gitea-${GITEA_VERSION}-linux-amd64 gitea

RUN echo "sh /opt/base.sh" >> /opt/start_gitea.sh
RUN echo "${BASE_PATH}/gitea/gitea web -c /onedrive/Gitea/custom/conf/app.ini" >> /opt/start_gitea.sh
RUN chmod 777 /opt/start_gitea.sh

ENTRYPOINT ["sh","-c","/opt/start_gitea.sh"]
