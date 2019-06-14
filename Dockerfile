FROM php:7.3.6-fpm-alpine3.9

WORKDIR /var/www

RUN apk add bash mysql-client
RUN apk --update add wget curl git php php-curl php-openssl php-json php-phar php-dom

RUN docker-php-ext-install pdo pdo_mysql

RUN rm -rf /var/www/html
COPY . /var/www
RUN ln -s public html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

RUN composer install && \
   cp .env.example .env && \ 
   php artisan key:generate && \
   php artisan config:cache && \
   rm /var/cache/apk/*  

EXPOSE 9000
ENTRYPOINT [ "php-fpm"]