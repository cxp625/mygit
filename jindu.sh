#######################
#显示进度
#author:cxp625
######################

#!/bin/bash
jindu(){
while :
do
echo -n "#"
sleep 0.2
done
}
jindu &
cp -a $1 $2
kill $! >/dev/null
echo "拷贝完成"
