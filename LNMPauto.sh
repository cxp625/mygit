#!/bin/bash
yum -y install mariadb mariadb-server mariadb-devel php php-fpm php-mysql


systemctl start  mariadb
if [ $? -eq 0 ];then
echo "数据库服务启动成功"
else
echo "数据库服务器启动失败"
fi
systemctl start php-fpm
if [ $? -eq 0 ];then
echo "php服务启动成功"
else
echo "php服务器启动失败"
fi

