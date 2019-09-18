#!/bin/bash

echo 进行主机名设置
echo 'B.tedu.com' > /etc/hostname
echo 主机名设置成功
echo 主机名为
cat /etc/hostname
echo 进行设置IP地址和子网掩码
read -p '请按照格式输入 192.168.4.7/24' a
nmcli connection modify eth0 ipv4.method manual ipv4.addresses $a  connection.autoconnect yes
nmcli connection up eth0
echo 你设置的IP地址是
ifconfig | head -2

read -p '是否设置网关Y/N' a
if [ '$a' =='Y'  ];then
 nmcli connection modify eth0 ipv4.method manual ipv4.getway $a  connection.autoconnect yes
nmcli connection up eth0
fi

