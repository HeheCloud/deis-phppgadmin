FROM maxexcloo/nginx-php:latest
MAINTAINER Cloud Mario <smcz@qq.com>

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y curl && \
	apt-get clean

# install etcdctl
RUN curl -sSL -o /usr/local/bin/etcdctl https://s3-us-west-2.amazonaws.com/get-deis/etcdctl-v0.4.9 \
    && chmod +x /usr/local/bin/etcdctl

# install confd
RUN curl -sSL -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd


ENV TZ "Asia/Shanghai"
ENV VERSION 5.1

RUN mkdir -p /data/http && \
	cd /data/http && \
	wget -O - "http://www.sourceforge.net/projects/phppgadmin/files/phpPgAdmin%20%5Bstable%5D/phpPgAdmin-${VERSION}/phpPgAdmin-${VERSION}.tar.gz/download" | tar --strip-components=1 -x -z && \
	rm -rf conf/config.inc.php-dist CREDITS DEVELOPERS FAQ HISTORY INSTALL TODO TRANSLATORS

ADD data /data

CMD ["/app/bin/boot"]
