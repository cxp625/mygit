#####################################################
###爬取网页上的ppt.ppt页面都是由图片组成的.并且每个主题都新建
###一个文件夹.每天的内容都新建一个文件夹来保存
#####################################################
from urllib import request
import os
import re
for a in {'ADMIN','ENGINEER','SERVICES','NETWORK','SHELL','OPERATION','CLUSTER','PROJECT1'}:
    if a == 'ADMIN' :
        day = 8
    if a == 'ENGINEER':
        day = 7
    if a == 'SERVICES':
        day = 7
    if a == 'NETWORK':
        day = 6
    if a == 'SHELL':
        day = 7
    if a == 'OPERATION':
        day = 8
    if a == 'CLUSTER':
        day = 5
    if a == 'PROJECT1':
        day = 5
    print(day)
    if os.path.isdir("/home/student/pc/all/"+a):
        print("/home/student/pc/all/"+a+"已经存在")
    else:
        os.mkdir("/home/student/pc/all/"+a)
    for i in range(1,day):
        if os.path.isdir("/home/student/pc/all/"+a+"/day0"+str(i)):
            print("/home/student/pc/all/"+a+"/day0"+str(i)+"已经存在")
        else:
            os.mkdir("/home/student/pc/all/"+a+"/day0"+str(i))
        url= 'http://tts.tmooc.cn/ttsPage/LINUX/NSDTN201904/'+a+'/DAY0'+str(i)+'/COURSE/ppt.html'
        print(url)
        url_request=request.Request(url)
        url_response=request.urlopen(url_request)
        data=url_response.read().decode('utf-8')
        jpglist=re.findall('LINUXNSD_V01'+a+'DAY0'+str(i)+'_0[0-9][0-9].png',data)
        print('pnglist',jpglist)
        n=1

        for each in jpglist: 	
            str2='http://tts.tmooc.cn/ttsPage/LINUX/NSDTN201904/'+a+'/DAY0'+str(i)+'/COURSE/'+each
            print("str",str2)
            try:
                 request.urlretrieve(str2,'/home/student/pc/all/%s/day0%s/NO%s.png' %(a,str(i) ,n))
            except Exception as e:
                print(e)
            finally:
                print('this is num %s com' %n)
            n+=1
