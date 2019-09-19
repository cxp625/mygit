##################################
##爬取指定的页面图片
#################################
from urllib import request
import re

url= 'http://tts.tmooc.cn/ttsPage/LINUX/NSDTN201904/ADMIN/DAY05/COURSE/ppt.html'

url_request=request.Request(url)
url_response=request.urlopen(url_request)
data=url_response.read().decode('utf-8')
jpglist=re.findall('LINUXNSD_V01ADMINDAY05_0[0-9][0-9].png',data)
print('pnglist',jpglist)
n=1

for each in jpglist:
	
	str='http://tts.tmooc.cn/ttsPage/LINUX/NSDTN201904/ADMIN/DAY05/COURSE/'+each
	print("str",str)
	try:
		request.urlretrieve(str,'/home/student/pc/day5//%s.png' %n)
	except Exception as e:
		print(e)
	finally:
		print('this is num %s com' %n)
	n+=1
