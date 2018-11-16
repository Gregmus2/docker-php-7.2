FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
        libicu-dev \
        libpq-dev \
        libbz2-dev \
        git \
        vim \
        wget \
        libevent-dev \
        librabbitmq-dev \
        libmcrypt-dev \
        iproute2 \
        telnet \
        zlib1g-dev \
        unzip
RUN docker-php-ext-install mcrypt intl pgsql pdo_pgsql bcmath opcache zip && docker-php-ext-enable opcache

RUN yes | pecl install xdebug-2.5.0 && docker-php-ext-enable xdebug
COPY xdebug_additional /
RUN cat /xdebug_additional >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY www.conf /usr/local/etc/php-fpm.d/symfony.pool.conf
COPY php.ini /usr/local/etc/php/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ssh/* /root/.ssh/

COPY entrypoint.sh /
RUN chmod 777 /entrypoint.sh
ENTRYPOINT /entrypoint.sh