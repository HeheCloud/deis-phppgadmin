FROM alpine:3.1
MAINTAINER Cloud Mario <smcz@qq.com>

# install common packages
RUN apk add --update-cache curl bash sudo php && \
	rm -rf /var/cache/apk/*

# install etcdctl
RUN curl -sSL -o /usr/local/bin/etcdctl http://sinacloud.net/hehe/etcd/etcdctl-v0.4.9 \
	&& chmod +x /usr/local/bin/etcdctl

# install confd
RUN curl -sSL -o /usr/local/bin/confd http://sinacloud.net/hehe/confd/confd-0.11.0-linux-amd64 \
	&& chmod +x /usr/local/bin/confd

ENV TZ "Asia/Shanghai"
ENV VERSION 5.1

ADD . /app

RUN chmod +x /app/bin/boot

RUN cd /app && \
	wget -O - "http://sinacloud.net/hehe/phppgadmin/phpPgAdmin-${VERSION}.tar.gz" | tar -xz && \
	mv phpPgAdmin* http && \
	cd http && \
	rm -rf conf/config.inc.php-dist CREDITS DEVELOPERS FAQ HISTORY INSTALL TODO TRANSLATORS

CMD ["/app/bin/boot"]
EXPOSE 8000
