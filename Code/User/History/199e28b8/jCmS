# FROM centos:7

# ARG USER_ID=14
# ARG GROUP_ID=50

# RUN yum -y update && yum clean all
# RUN yum install -y \
# 	vsftpd \
# 	db4-utils \
# 	db4 \
# 	iproute && yum clean all

# RUN usermod -u ${USER_ID} ftp
# RUN groupmod -g ${GROUP_ID} ftp
# RUN mkdir -p /var/run/ftp/pub

# COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
# RUN chmod 644 /etc/vsftpd/vsftpd.conf

# # RUN chmod +x /usr/sbin/run-vsftpd.sh
# # RUN mkdir -p /home/vsftpd/
# # RUN chown -R ftp:ftp /home/vsftpd/

# EXPOSE 20 21

# CMD ["/usr/sbin/vsftpd","-obackground=NO"]

