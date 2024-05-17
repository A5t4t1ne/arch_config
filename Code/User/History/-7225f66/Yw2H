FROM centos:7

RUN yum -y update && yum -y install vsftpd net-tools

RUN mkdir -p /home/ftpusers
COPY ./pub/protocol.txt /home/ftpusers/protocol.txt
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN chown root:root /etc/vsftpd/vsftpd.conf
RUN ls -la /

EXPOSE 20 21

RUN touch /var/log/xferlog
ADD start_ftp.sh /start_ftp.sh
RUN chown root:root /start_ftp.sh
CMD ["/start_ftp.sh"]


