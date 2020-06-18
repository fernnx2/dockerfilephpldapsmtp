FROM debian:buster-slim
LABEL maintainer=devfernando95@gmail.com 
ENV REPOSITORY="https://github.com/fernnx2/phpldapsmtp"
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --no-install-suggests -y iproute2 iputils-ping\
    apache2 php7.3 git ca-certificates libapache2-mod-php7.3 php7.3-ldap

RUN a2enmod php7.3
RUN a2enmod rewrite

EXPOSE 80
WORKDIR /var/www/html



ARG CACHE_DATE=22-05-2020
RUN git clone ${REPOSITORY} && \
    echo "#\!/bin/bash \n\
                  sed -i -e \"s/URLREAD/\$URLREAD/; s/URLWRITE/\$URLWRITE/\" /var/www/html/phpldapradius/auth/auth.php && \
                  apachectl -D FOREGROUND " > entrypoint.sh && chmod +x entrypoint.sh


ENTRYPOINT ["/bin/bash", "/var/www/html/entrypoint.sh"]


