#!/bin/bash

#To enable password authentication
sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
systemctl restart sshd
service sshd restart

useradd admin
echo ${password} | passwd --stdin admin
sudo usermod -aG wheel admin


