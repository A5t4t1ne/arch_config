FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    vim \
    sudo \
    curl \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    gnupg-agent

# install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

RUN chmod 750 /usr/bin/docker

# sshd configurations
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

# run user-creation and home-directory management script
RUN mkdir -p /home
COPY initial_home_contents /home
COPY create_users.sh create_users.sh
RUN chmod +x create_users.sh && /create_users.sh
RUN rm create_users.sh

# PE to groot
RUN chmod 1777 /home/common_playground
RUN chown Drax:Drax /home/common_playground/groot_is_learning.py
RUN chmod 764 /home/common_playground/groot_is_learning.py

# cronjob
RUN apt-get install -y cron
RUN chmod 744 /home/Rocket/get_the_juice.sh
RUN chown Rocket:Rocket /home/Rocket/get_the_juice.sh
COPY get_the_juice_cron /etc/cron.d/get_the_juice
RUN chmod 644 /etc/cron.d/get_the_juice
RUN usermod -aG Rocket Gamora
RUN crontab /etc/cron.d/get_the_juice
RUN service cron restart

RUN echo "r00t_fl4g: 1_4m_th3_r00t_0f_4ll_3v1l" > /root/flag.txt
RUN echo "root:very_long_passwd_lol_4321"  | chpasswd
# RUN echo 'root:root' | chpasswd


EXPOSE 22

# set entrypoint
CMD ["/usr/sbin/sshd", "-D"]
