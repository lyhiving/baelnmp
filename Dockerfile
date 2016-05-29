# Base image to use, this must be set as the first line
FROM ansible/centos7-ansible:1.7

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER lyhiving lyhiving@gmail.com

# 暴露的端口
EXPOSE 8080

WORKDIR  /home/bae/app

# 操作yum源
RUN mv /etc/yum.repos.d /etc/yum.repos.d.bak
RUN mkdir /etc/yum.repos.d
COPY ["__ORG__/Centos-7.repo", "/etc/yum.repos.d/Centos-7.repo"]
RUN yum clean all
RUN yum makecache

# 下载依赖包
RUN yum install -y wget telnet gcc gcc-c++ autoconf libxml libxml2-devel libcurl libcurl-devel libpng libpng-devel freetype freetype-devel gd gd-devel libjpeg libjpeg-devel openssl libvpx libvpx-devel libmcrypt libmcrypt-devel ncurses ncurses-devel wget openssl openssl-devel pcre pcre-devel vim cmake bzip2 screen

# 解压并安装lnmp
COPY ["__ORG__/lnmp.tar.gz", "/var/install/lnmp.tar.gz"]
RUN cd /var/install;tar zxvf lnmp.tar.gz;mv lnmp1.3 lnmp;mv lnmp/install.sh lnmp/install.sh.bak
COPY ["__ORG__/install.sh", "/var/install/lnmp/install.sh"]
COPY ["__ORG__/main.sh", "/var/install/lnmp/main.sh"]
RUN cd /var/install/lnmp;chmod a+x install.sh;./install.sh lnmp root y 6 6 1

# 安装完成后处理
COPY ["__ORG__/nginx.conf", "/usr/local/nginx/conf/nginx.conf"]
RUN ln -s /home/wwwroot/app /home/bae/app
RUN rm -rf /var/install
RUN yum install -y openssh-server


ADD __ORG__/start.sh /start.sh
EXPOSE 80
EXPOSE 22
RUN chmod +x /start.sh

WORKDIR  /home/bae/log
RUN cp /root/lnmp-install.log /home/bae/log/lnmp-install.log

CMD ["/bin/bash", "/start.sh"]