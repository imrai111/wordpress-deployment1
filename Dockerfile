FROM wordpress:latest

RUN chown -R www-data:www-data  /var/www/html/wp-content

EXPOSE 80

