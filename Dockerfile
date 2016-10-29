FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN \
  apt-get install -y mariadb-server && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y python-pip
RUN apt-get install -y net-tools
RUN apt-get install -y nginx
RUN rm -rf /var/lib/-y apt/lists/*
RUN pip install flask

ADD start.sh /start.sh
ADD conf/nginx-default /etc/nginx/sites-available/default
ADD flask /flask

VOLUME ["/mnt", "/var/lib/mysql"]
EXPOSE 80 443
CMD ["/start.sh"]
