FROM centos:8
MAINTAINER donkeywon K <donkeywon@163.com>

RUN echo "fastestmirror=True" >> /etc/dnf/dnf.conf && \
    dnf install -y glibc-langpack-en epel-release wget net-tools dnf-plugins-core && \
    dnf clean all && \
    rm -rf /var/cache/dnf/* && \
    dnf config-manager --set-enabled powertools && \
    echo "root:qweasd" | chpasswd && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "alias ls='ls --color=auto'" >> /root/.bashrc && \
    echo "alias l='ls -lah'" >> /root/.bashrc && \
    echo "alias ll='ls -lh'" >> /root/.bashrc && \
    echo "alias la='ls -lAh'" >> /root/.bashrc && \
    echo "" >> /opt/base.sh && \
    chmod 777 /opt/base.sh

ENTRYPOINT ["sh","-c","/opt/base.sh"]
