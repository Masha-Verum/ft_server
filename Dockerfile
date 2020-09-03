# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbantam <mbantam@student.21-school.ru>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/12 15:33:04 by mbantam           #+#    #+#              #
#    Updated: 2020/09/03 10:49:42 by mbantam          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get install -y nginx

RUN apt-get install -y mariadb-server

RUN apt-get install -y php-fpm php-mysql php-mbstring php-zip php-gd php-curl php-intl php-soap php-xml php-xmlrpc php-zip

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=School21/OU=mbantam/CN=mbantam"

WORKDIR /var/www

RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*

COPY srcs/ .

RUN mv localhost.conf /etc/nginx/sites-available/default
 #   && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

RUN apt-get install -y wget \
    && wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz 

RUN mkdir /var/www/phpmyadmin \
    && tar -xzvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/phpmyadmin \
    && mv phpmyadmin.inc.php /var/www/phpmyadmin/config.inc.php

RUN wget https://wordpress.org/latest.tar.gz

RUN tar -xvzf latest.tar.gz \
    && mv wp-config_srcs.php /var/www/wp-config.php

#RUN mkdir -p /var/lib/phpmyadmin/tmp \
 #   && chown -R www-data:www-data /var/lib/phpmyadmin

RUN chmod +x *.sh

RUN bash mysql.sh

RUN bash services.sh

RUN bash

EXPOSE 80 443
