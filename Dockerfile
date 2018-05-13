FROM mysql:5.7

RUN apt-get update
RUN apt-get install -y wget telnet
RUN wget https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_linux_x86_64.tgz
RUN tar -xvzf entrykit_0.4.0_linux_x86_64.tgz
RUN rm entrykit_0.4.0_linux_x86_64.tgz
RUN mv entrykit /usr/local/bin/
RUN entrykit --symlink

ADD add-server-id.sh /usr/local/bin/
ADD init-data.sh /usr/local/bin/
ADD etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/
ADD etc/mysql/conf.d/mysql.cnf /etc/mysql/conf.d/
ADD prepare.sh /docker-entrypoint-initdb.d
ADD sql /sql

ENTRYPOINT [ \
  "prehook", \
    "add-server-id.sh", \
    "--", \
  "docker-entrypoint.sh" \
]

CMD ["mysqld"]
