FROM donkeywon/centos-base
MAINTAINER donkeywon K <donkeywon@163.com>

#RUN wget http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/mysql-community-client-5.7.34-1.el7.x86_64.rpm -O /tmp/1.rpm && \
#    wget http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/mysql-community-common-5.7.34-1.el7.x86_64.rpm -O /tmp/2.rpm && \
#    wget http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/mysql-community-libs-5.7.34-1.el7.x86_64.rpm -O /tmp/3.rpm && \
#    wget http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/mysql-community-server-5.7.34-1.el7.x86_64.rpm -O /tmp/4.rpm && \
#    dnf localinstall -y /tmp/1.rpm /tmp/2.rpm /tmp/3.rpm /tmp/4.rpm && \
#    rm -f /tmp/1.rpm /tmp/2.rpm /tmp/3.rpm /tmp/4.rpm

RUN wget http://repo.mysql.com/yum/mysql-5.7-community/docker/el/7/x86_64/mysql-community-server-minimal-5.7.34-1.el7.x86_64.rpm -O /tmp/1.rpm && \
    dnf localinstall -y /tmp/1.rpm && \
    rm -f /tmp/1.rpm

RUN mv /etc/my.cnf /etc/my.cnf.origin
RUN ln -s /shared/env/docker_centos/data/mysql/my.cnf /etc/my.cnf

RUN echo "sh /opt/base.sh" >> /opt/start_mysql.sh
RUN echo "rm -f /var/run/mysqld/mysqld.sock.lock" >> /opt/start_mysql.sh
RUN echo "/usr/sbin/mysqld --daemonize --user=mysql" >> /opt/start_mysql.sh
RUN echo "tail -f /var/log/mysqld.log" >> /opt/start_mysql.sh
RUN chmod 777 /opt/start_mysql.sh

RUN dnf clean all && \
    rm -rf /var/cache/dnf/*

ENTRYPOINT ["sh","-c","/opt/start_mysql.sh"]
