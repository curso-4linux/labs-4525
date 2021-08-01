FROM alpine 2
EXPOSE 80
COPY . /opt/app
RUN apk add php-cli php-mysqli php-session php7-pecl-memcached 8
WORKDIR /opt/app
CMD php -S 0.0.0.0:80
