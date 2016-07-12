FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
	apache2 \
	wget \
	libapache2-mod-php \
	php-mcrypt \
	php-mysql \
	php-gd \
	php-curl \
	php-xml \
	graphicsmagick \
	supervisor \
	php-soap \
	php-zip
COPY installed_typo3.tar.gz /installed_typo3.tar.gz
RUN tar -xvjf /installed_typo3.tar.gz
RUN rm -R /var/www/html
RUN mv /www /var/www/html

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
WORKDIR /var/www/html

RUN sed -i "s/max_execution_time = 30/max_execution_time = 240/g" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/; max_input_vars = 1000/max_input_vars = 1500/g" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/'password' => '123456',/'password' => '12345123',/g" /var/www/html/typo3conf/LocalConfiguration.php
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

COPY  start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
