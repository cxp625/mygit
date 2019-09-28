#!/bin/bash
########################################
#循环显示eth0网卡发送和接收的数据包流量
#
#author:cxp625
########################################
echo "接收流量为$(ifconfig eth0 | awk '/RX pack/{print $5}')"
echo "接收流量为$(ifconfig eth0 | awk '/TX pack/{print $5}')"

