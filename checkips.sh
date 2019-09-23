######################################
#根据输入的IP地址前三位,来检测这个网络
#那些电脑是开机的,那些是关机的,并显示在
#屏幕.这是多线程版本
#author:cxp625
######################################
read -p "请输入你要检测的网段前三位" ips
myping(){

ping -c2 -i0.3 -w1 $1 &>/dev/null
if [ $? -eq 0 ];then
 echo "$ips.$i is up"
else

echo "$ips.$i is down"
fi

}
for i in {1..254}
do
myping $ips.$i&

done
wait
