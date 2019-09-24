#!/bin/bash
#################################33######################
#循环安装几台电脑的服务和修改配置文件
#
#author:cxp625
#########################################################

##################
#拷贝密匙到其他电脑
#
###################
ssh-keygen   -f /root/.ssh/id_rsa    -N ''
for i in 20  21  22  23
 do
     ssh-copy-id  192.168.4.$i
 done

echo "192.168.4.20 client2 
192.168.4.21 node1_2
192.168.4.22 node2_2
192.168.4.23 node3_2" >>/etc/hosts
echo "[mon]
name=mon
baseurl=ftp://192.168.4.254/ceph/MON
gpgcheck=0
[osd]
name=osd
baseurl=ftp://192.168.4.254/ceph/OSD
gpgcheck=0
[tools]
name=tools
baseurl=ftp://192.168.4.254/ceph/Tools
gpgcheck=0
[dvd]
name=dve
baseurl=ftp://192.168.4.254/centos-1804
enabled=1
gpgcheck=0 ">/etc/yum.repos.d/local.repo 

for i in  node1_2 node2_2 node3_2 client2
do

 scp /etc/hosts $i:/etc/   ###拷贝hosts文件到其他电脑
 scp /etc/yum.repos.d/local.repo $i:/etc/yum.repos.d ##拷贝Yum源配置到其他电脑
 scp /etc/chrony.conf $i:/etc/  #同步时间服务配置
 ssh $i "systemctl restart chronyd"  #远程开启时间同步服务
done


if [ ! -d "/root/ceph-cluster" ];then


mkdir /root/ceph-cluster
fi
cd /root/ceph-cluster

yum -y install ceph-deploy
ceph-deploy new node1_2 node2_2 node3_2

for i in node1_2 node2_2 node3_2
do
 ssh $i "yum -y install ceph-mon ceph-osd ceph-mds ceph-radosgw"
done
ceph-deploy mon create-initial
for i in node1_2 node2_2 node3_2
do
 ssh $i "parted /dev/vdb mklabel gpt"  ##进行分区格式设置
 ssh $i "parted /dev/vdb  mkpart primary 1 50%" ##进行第一个分区
 ssh $i "parted /dev/vdb mkpart primary 50% 100%" ##进行第二个分区
done
for i in node1_2 node2_2 node3_2
do
  ssh $i "chown  ceph.ceph  /dev/vdb1" ##修改磁盘权限
  ssh $i "chown  ceph.ceph  /dev/vdb2" ##修改磁盘权限


done
echo "ENV{DEVNAME}=="/dev/vdb1",OWNER="ceph",GROUP="ceph"
ENV{DEVNAME}=="/dev/vdb2",OWNER="ceph",GROUP="ceph""> /etc/udev/rules.d/70-vdb.rules
for i in node1_2 node2_2 node3_2
do
scp /etc/udev/rules.d/70-vdb.rules $i:/etc/udev/rules.d/
done

ceph-deploy disk  zap  node1_2:vdc   node1_2:vdd  node2_2:vdc   node2_2:vdd  node3_2:vdc   node3_2:vdd
ceph-deploy osd create  node1_2:vdc:/dev/vdb1 node1_2:vdd:/dev/vdb2 node2_2:vdc:/dev/vdb1 node2_2:vdd:/dev/vdb2 node3_2:vdc:/dev/vdb1 node3_2:vdd:/dev/vdb2
sleep 20
ceph  -s
sleep 20
rbd create test1-image --image-feature  layering --size 8G
rbd create test2-image --image-feature  layering --size 10G
rbd list

ssh client2 "yum -y  install ceph-common"
ssh client2 "scp /etc/ceph/ceph.conf 192.168.4.20:/etc/ceph/"
ssh client2 "scp /etc/ceph/ceph.client.admin.keyring  192.168.4.20:/etc/ceph/"

ssh client2 "rbd map test1-image"
ssh client2 "rbd map test2-image"
#ssh client2 "mkfs.xfs /dev/rbd0"
#ssh client2 "mount /dev/rbd0 /mnt/"
#ssh client2 "echo "test" > /mnt/test.txt"


