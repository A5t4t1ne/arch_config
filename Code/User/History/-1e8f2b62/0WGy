FROM php:8.0-fpm

RUN mkdir -p /var/www/html/images
RUN chown -R www-data:www-data /var/www/html/images
RUN chmod -R 755 /var/www/html/images

RUN mkdir -p /var/www/html/groot_stuff

# Start (default command from base image)
# CMD ["nginx", "-g", "daemon off;"]
