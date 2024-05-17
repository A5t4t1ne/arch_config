FROM php:8.0-fpm

# # Copy the startup script into the image
# COPY startup-script.sh /startup-script.sh

# # Make the script executable
# RUN chmod +x /startup-script.sh

# Install and set Python 3 as the default Python version
# RUN apt-get update && apt-get install -y python3
# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

RUN mkdir -p /var/www/html/images
RUN chown -R www-data:www-data /var/www/html/images
RUN chmod -R 755 /var/www/html/images


# Start (default command from base image)
# CMD ["nginx", "-g", "daemon off;"]
