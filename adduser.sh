############################################
#创建用户和密码.如果不输入密码
#默认密码为123456
#author:cxp625
###########################################

#!/bin/bash

read -p"请输入用户名" users
stty -echo
read -p"请输入密码" passwds
stty echo
passs=${paswds:-123456}
if [ -z $users ];then
echo "用户名不能为空"
exit 2
fi

useradd $users
echo $passs | passwd --stdin $users

