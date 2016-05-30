# Base image to use, this must be set as the first line
FROM centos:centos6

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER lyhiving lyhiving@gmail.com

WORKDIR  /home/bae/app

# 操作yum源
RUN mv /etc/yum.repos.d /etc/yum.repos.d.bak
RUN mkdir /etc/yum.repos.d
COPY ["__ORG__/Centos.repo", "/etc/yum.repos.d/Centos.repo"]
RUN yum clean all
RUN yum makecache

# 下载依赖包
RUN yum install -y wget telnet gcc gcc-c++ autoconf libxml libxml2-devel libcurl libcurl-devel libpng libpng-devel freetype freetype-devel gd gd-devel libjpeg libjpeg-devel openssl libvpx libvpx-devel libmcrypt libmcrypt-devel ncurses ncurses-devel wget openssl openssl-devel pcre pcre-devel vim cmake bzip2 screen openssh-server openssh-clients sudo passwd

# LNMP
COPY ["__ORG__/lnmp.tar.gz", "/var/install/lnmp.tar.gz"]
RUN cd /var/install;tar zxvf lnmp.tar.gz;mv lnmp1.3 lnmp;mv lnmp/install.sh lnmp/install.sh.bak
COPY ["__ORG__/install.sh", "/var/install/lnmp/install.sh"]
COPY ["__ORG__/main.sh", "/var/install/lnmp/main.sh"]
RUN cd /var/install/lnmp;chmod a+x install.sh;./install.sh lnmp root y 6 6 1

# CONFIG LNMP
COPY ["__ORG__/nginx.conf", "/usr/local/nginx/conf/nginx.conf"]
RUN ln -s /home/wwwroot/app /home/bae/app
RUN rm -rf /var/install

## web logs
VOLUME ["/home/bae/"]

#SSHD
#RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
#RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
#RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
#RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
#RUN echo 'root:root' | chpasswd


# PORT
EXPOSE 22
EXPOSE 80
EXPOSE 3306
EXPOSE 8080

#START  
ADD __ORG__/start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/bin/bash", "/start.sh"]