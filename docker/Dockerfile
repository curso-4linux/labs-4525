FROM alpine
EXPOSE 80
COPY . /opt/app
RUN apk add php-cli php-mysqli php-session php7-pecl-memcached
WORKDIR /opt/app
CMD php -S 0.0.0.0:80
