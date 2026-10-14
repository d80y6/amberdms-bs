# Use legacy PHP 5.6 with Apache
FROM php:5.6-apache

# Install required PHP extensions for AmberDMS (mysql, mysqli, pdo_mysql, gd)
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) mysql mysqli pdo_mysql gd

# Enable Apache mod_rewrite for custom route handling
RUN a2enmod rewrite

# Copy AmberDMS source code into Apache's web root
COPY . /var/www/html/

# Set correct ownership permissions
RUN chown -R www-data:www-data /var/www/html

# Railway dynamically maps PORT, but legacy Apache defaults to 80
EXPOSE 80
