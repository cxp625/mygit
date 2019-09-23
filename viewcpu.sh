#################################
##监视内存小于500M,根分区小于1000M
##发邮件给root用户
##Author cxp625
################################

#!/bin/bash
disk_size=$(df |awk '/\/$/{print $4}')
freecpu_size=$(free |awk '/Mem/{print $4}')
while :
do
if [ $disk_size -le 1024000  ];then
echo "硬盘空间小于1000M." | mail -s 'jg' student
fi
if  [ $freecpu_size -le 51200 ];then
echo "内存小于500M" |mail -s 'warr ' student
fi
sleep 1000
done
