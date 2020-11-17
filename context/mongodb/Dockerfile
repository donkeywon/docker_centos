FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

COPY mongodb.repo /etc/yum.repos.d/

RUN dnf install -y mongodb-org-server && \
	mv /etc/mongod.conf /etc/mongod.conf.origin && \
	ln -s /shared/env/docker_centos/data/mongodb/mongod.conf /etc/mongod.conf

RUN echo "sh /opt/base.sh" >> /opt/start_mongod.sh
RUN echo "/usr/bin/mongod -f /etc/mongod.conf" >> /opt/start_mongod.sh
RUN echo "tail -f /var/log/mongodb/mongod.log" >> /opt/start_mongod.sh
RUN chmod 777 /opt/start_mongod.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_mongod.sh"]
