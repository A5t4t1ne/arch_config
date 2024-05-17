FROM ubuntu:latest

RUN apt-get update && apt-get install -y vsftpd
RUN echo "anonymous_enable=YES" >> /etc/vsftpd.conf
RUN echo "local_enable=YES" >> /etc/vsftpd.conf
RUN echo "write_enable=YES" >> /etc/vsftpd.conf
RUN echo "local_umask=022" >> /etc/vsftpd.conf
RUN echo "dirmessage_enable=YES" >> /etc/vsftpd.conf
RUN echo "xferlog_enable=YES" >> /etc/vsftpd.conf
RUN echo "listen=YES" >> /etc/vsftpd.conf
RUN echo "pam_service_name=vsftpd" >> /etc/vsftpd.conf
RUN echo "userlist_enable=YES" >> /etc/vsftpd.conf
RUN echo "tcp_wrappers=YES" >> /etc/vsftpd.conf
RUN echo "anon_root=/home/ftpusers" >> /etc/vsftpd.conf

EXPOSE 20 21

CMD vsftpd /etc/vsftpd.conf