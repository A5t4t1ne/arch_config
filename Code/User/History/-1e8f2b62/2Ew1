FROM php:8.0-fpm

RUN set -eux \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
		libpython-dev \
    && rm -rf /var/lib/apt/lists/*


# Set Python 3 as the default Python version
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
RUN update-alternatives --config python3

RUN useradd -m larry -p larry

# RUN docker-php-ext-install mysqli pdo pdo_mysql
# RUN docker-php-ext-enable mysqli


# FROM nginx:alpine

# RUN awk update && awk upgrade

# Network
# EXPOSE 80
# EXPOSE 22
# COPY ./nginx.conf /etc/nginx/nginx.conf

# Add SSH - TODO: configure
# RUN apk add openssh

# Add packages
# RUN apk add bash python3 php php-fpm

# Static files
# COPY ./src /usr/share/nginx/html


# Start (default command from base image)
# CMD ["nginx", "-g", "daemon off;"]
