FROM php:7.4.10-cli

# apt dependancies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
        git \
        libicu-dev

RUN docker-php-ext-install gettext

# core extensions
RUN docker-php-ext-install \
        intl \
        opcache \
        pcntl

# pecl extensions
RUN pecl channel-update pecl.php.net \
    && pecl install \
        apcu-5.1.18 \
    && docker-php-ext-enable \
        apcu

RUN apt-get autoremove --purge -y && apt-get clean

COPY docker/conf.d /usr/local/etc/php/conf.d

COPY . /app

WORKDIR /app

CMD ["php", "/app/build.php"]

