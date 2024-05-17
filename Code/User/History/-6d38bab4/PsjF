# create docker image for ftp server
FROM python:3.9
RUN apt-get update && apt-get install -y vsftpd
COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf

# create user
RUN useradd -m larry -p larry

# create directory
RUN mkdir -p /home/larry/ftp/upload

# copy files
COPY ./files/* /home/larry/ftp/upload

