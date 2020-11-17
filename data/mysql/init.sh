mysqld --initialize
tail -1 /var/log/mysqld.log
ALTER USER 'root'@'localhost' IDENTIFIED BY 'qweasd';
grant all privileges on *.* to donkeywon@'%' identified by 'qweasd';
