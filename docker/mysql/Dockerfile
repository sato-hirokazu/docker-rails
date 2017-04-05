FROM mysql:latest

RUN usermod -u 1000 mysql
RUN chmod 777 /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql

ADD mysql.cnf /etc/mysql/my.cnf
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
