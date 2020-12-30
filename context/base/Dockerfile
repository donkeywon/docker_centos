FROM centos:8
MAINTAINER donkeywon K <donkeywon@163.com>

RUN mkdir -p /usr/local/env

RUN echo "fastestmirror=True" >> /etc/dnf/dnf.conf && \
    dnf update -y && \
    dnf install -y glibc-langpack-en epel-release wget net-tools dnf-plugins-core && \
    dnf config-manager --set-enabled powertools && \
    echo "root:qweasd" | chpasswd && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

RUN echo "" >> /opt/base.sh
RUN chmod 777 /opt/base.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/base.sh"]
