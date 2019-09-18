#!/bin/bash
#############################################################


###本脚本为系统运维小工具集合                              #


############################################################


###########################################################

##display函数是显示本机系统的版本,主机名,网卡信息,系统内核
##########################################################
display(){
 vers=$(cat /etc/redhat-release)
 echo "系统版本为$vers"
 echo "本机主机名"$HOSTNAME
 ipaddress=$(ifconfig |head -2)
 echo "本机第一个网卡的信息为:$ipaddress"
 uname=$(uname -r)
 echo "本机系统内核为$uname"
 
}
########################################################

###批量修改文件扩展名
########################################################
changekzm(){
echo "该脚本为批量修改文件的扩展名"
echo '使用方法是:函数名 $1 $2'
# "$name1是需要修改的文件扩展名,$name2是改后的扩展名称"
read -p"请输入要修改文件的路径,请输入完整" adress
read -p"是需要修改的文件扩展名" name1
read -p"改后的扩展名称" name2
for i in $(ls $adress*.$name1)
do
 named=${i%.*}
mv $i $named.$name2
done
}

######################################################

####随机生成任意位密码
######################################################

rand(){
x=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789

pass=''
read -p "请输入你要生成的密码长度" leng

for i in $(seq $leng)
do
 num=$[RANDOM%62]
 tmp=${x:num:1}
 pass=${pass}$tmp

done
 echo "你的密码是$pass"

}

######################################################

####nigux自动部署服务
######################################################

nigx(){
yum -y install gcc openssl-devel pcre-devel &>/dev/null
read -p "请输入nigx的源码包路径" adress
cd $adress
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure
make
make install

}

#######################################################

#####批量快速ping网段电脑开机的电脑.并显示
######################################################
quickping(){
b=0
rm -rf /home/student/ipadress.txt
myping(){
ping -c1 -w1 $1 &>/dev/null
if [ $? -eq 0 ];then
     echo "$1" >>/home/student/ipadress.txt

fi
}
read -p"请输入你要ping的网段" wlan
read -p"请输入你要ping的ip地址最后结束位,即1-?" bit
for i in $(seq $bit)
do 
  nwlan=${wlan%.*}
  myping $nwlan.$i &

done
wait
for i in $(cat /home/student/ipadress.txt)
do
 let a++
done
b=$[bit-a]

echo "本次176.204.25.0网段正在运行的电脑台数为$a,没有运行的电脑台数为$b."
echo "他们分别是"
for i in $(cat /home/student/ipadress.txt)
do
 echo $i
done
###思考如何远程关闭计算机
#for i in $(cat /home/student/ipadress.txt)
#do
#   if  [ "$i" !=  "176.204.25.48" ];then
#     echo "他机地址是$i"
#    scp /home/student/马上关机,请保存好笔记.txt  student@176.204.25.$i:/home/student/桌面

#   else
#    echo "是我本机,不要操作.ip是 $i"
#   fi
#done

}
##################################################

###操作nigux的状态
##################################################
changenigux(){
echo "#######################################"
echo "#st开启|re重启|stop退出|sa查看状态    #"
echo "#######################################"
read -p"请选择你的操作" choise
case $choise in

st)
 /usr/local/nginx/sbin/nginx 
 echo "服务开启成功";;

stop)
 /usr/local/nginx/sbin/nginx -s stop 
 echo "服务已关闭" ;;
re)
 /usr/local/nginx/sbin/nginx -s stop
 /usr/local/nginx/sbin/nginx 
 echo "服务已重启";;
sa)
 netstat -ntulp |grep -q  nginx
 if [ $? -eq 0 ];then
 cecho 32 "服务正在运行中!"
  
else
 cecho 31 "服务未运行!"
 fi
 ;;

esac

}
while :
do
echo "                                                       *  ****      *  *  * "
echo "                                                       *    **  * *  * "
echo "                                                       *   **        * "
echo "                                                       *   * * * * *"
echo "                                                       *  *"
echo "                                                       *  *"
echo "                                                       * *"
echo "                                                       **"
echo "                                                       **"
echo "                                                       **"
echo "                                                       **"
echo "                                                       **"

echo "本程序使用方法: ds|显示系统信息 cg|批量修改扩展名 rd|随机生成任意为密码 ng|nigux服务自动部署 cnx|操作nigux的状态"
echo " qp|快速批量ping网段开机的电脑数以及明显ip地址 q|退出该程序"
read -p "请选择你需要的服务" choise
case $choise in
ds)
 display;;
cg)
 changekzm;;
rd)
 rand;;
ng)
nigx;;
q)
exit;;
qp)
quickping;;
cnx)
changenigux;;
esac
done

