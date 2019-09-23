#!/bin/bash

read -p"是否进行主机名设置" chosie
if [ "$chosie" == "Y" ];then
read -p "进行主机名设置" names
echo $names > /etc/hostname
echo 主机名设置成功
echo 主机名为
cat /etc/hostname
fi
read -p "是否进行ip地址和子网掩码设置" chosize
if [ "$chosize" == "Y" ];then

echo 进行设置IP地址和子网掩码
read -p '请按照格式输入 192.168.4.7/24' a
nmcli connection modify eth0 ipv4.method manual ipv4.addresses $a  connection.autoconnect yes
nmcli connection up eth0
echo 你设置的IP地址是
ifconfig | head -2
a1=${a%.*}
echo a1
fi
read -p '是否设置网关Y/N' a
if [ "$a" == "Y"  ];then
 nmcli connection modify eth0 ipv4.method manual ipv4.getway $a  connection.autoconnect yes
nmcli connection up eth0
fi
sed -i  "/^baseurl/s/192.168.2.254/$a1.254/" /etc/yum.repos.d/local.repo 

