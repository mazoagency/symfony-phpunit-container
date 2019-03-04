FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip

RUN apt-get install -y libzip-dev

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install pdo
RUN docker-php-ext-install opcache
RUN docker-php-ext-install zip

RUN apt-get install -y libpq-dev
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pdo_mysql

# Install INTL
RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

ADD custom.ini /usr/local/etc/php/conf.d/custom.ini

RUN useradd -m symfony
USER symfony

RUN composer --version

WORKDIR /var/www/symfony
