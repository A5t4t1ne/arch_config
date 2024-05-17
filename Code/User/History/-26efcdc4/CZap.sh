#!/bin/bash
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf &
tail -f /var/log/xferlog