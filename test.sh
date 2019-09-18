#!/bin/bash
cpu=$(uptime | awk '{print $NF}')
net_in=$(ifconfig eth0 | awk '/RX p/{print $5}')
net_out=$(ifconfig eth0 | awk '/TX p/{print $5}')
disk=$(df |awk '/\/$/{ print $4}')
user=$(cat /etc/passwd |wc -l)
login=$(who |wc -l)
proc=$(ps aux | wc -l)
soft=$(rpm -qa |wc -l)

echo "======本机性能如下==========="
echo "CPU15分钟平均负载为$cpu"
echo "eth0的进站流量为$net_in"
echo "eth0的出站流量为$net_in"
echo "硬盘剩余空间为$disk"
echo "本机用户数量为$user"
echo "本机现在登录用户数量为$login"
echo "本机运行进程数量为$proc"
echo "本机安装软件包数量为$soft"

