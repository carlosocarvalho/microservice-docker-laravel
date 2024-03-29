FROM php:7.3.6-fpm-alpine3.9

WORKDIR /var/www

RUN apk add bash mysql-client
RUN apk --update add wget curl git php php-curl php-openssl php-json php-phar php-dom openssl

RUN docker-php-ext-install pdo pdo_mysql


ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz


RUN rm -rf /var/www/html
COPY . /var/www
RUN ln -s public html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

# RUN composer install && \
#    rm /var/cache/apk/*  

EXPOSE 9000
ENTRYPOINT [ "php-fpm"]