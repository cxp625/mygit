#!/bin/bash
yum -y install gcc make  pcre-devel openssl-devel
useradd nginx
tar -xf /root/lnmp_soft.tar.gz
cd /root/lnmp_soft/
tar -xf /root/lnmp_soft/nginx-1.12.2.tar.gz
cd /root/lnmp_soft/nginx-1.12.2/
./configure --with-http_ssl_module --with-stream --with-http_stub_status_module --user=nginx --group=nginx
make
make install

/usr/local/nginx/sbin/nginx
if [ $? -eq 0 ];then
echo "nginx 安装成功,并且服务也成功启动"
else
echo"nginx安装成功,启动失败,自己滚去排错去吧,老夫尽力了."
echo"老夫提示你,只是安装服务启动服务.先去看看80端口"
fi

