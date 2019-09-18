#!/bin/bash
echo '开始还原...'
sleep 3
img_url=/var/lib/libvirt/images
xml_url=/etc/libvirt/qemu
sudo virsh destroy nsd01 &> /dev/null
echo $?
sudo  virsh undefine nsd01 &> /dev/null
echo $?
rm -rf $img_url/nsd01.img & >/dev/null
echo $?
qemu-img create -f qcow2 -b $img_url/.node_base.qcow2 $img_url/nsd01.img 5G &> /dev/null
echo $?
sudo virsh define /var/lib/libvirt/images/cxp.xml &> /dev/null
echo $?
sudo virsh start nsd01 &> /dev/null
echo $?
echo '还原成功'
sleep 3

