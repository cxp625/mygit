#!/bin/bash
a=0
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

#for i in $(cat /home/student/ipadress.txt)
#do
#   if  [ "$i" !=  "176.204.25.48" ];then
#     echo "他机地址是$i"
#    scp /home/student/马上关机,请保存好笔记.txt  student@176.204.25.$i:/home/student/桌面
 
#   else
#    echo "是我本机,不要操作.ip是 $i"
#   fi
#done

#scp /home/student/马上关机,请保存好笔记.txt  student@176.204.25.55:/home/student/桌面
