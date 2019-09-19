from urllib import request
import re

url= 'http://www.budejie.com/video/'
url2='http://mvideo.spriteapp.cn/video/2019/0805/70bd0b8c-b76f-11e9-8e9b-1866daeb0df1_wpcco.mp4'

'''url_request=request.Request(url)
url_response=request.urlopen(url_request)
data=url_response.read().decode('utf-8')
jpglist=re.findall('http.+?.mp4',data)
print('pnglist',jpglist)
n=1


for each in jpglist:
	
	print("str",each)
	try:
		request.urlretrieve(url2,'/home/student/pc/MP4/%s.mp4' %n)
	except Exception as e:
		print(e)
	finally:
		print('this is num %s com' %n)
	n+=1'''
url_request=request.Request(url2)
url_response=request.urlopen(url_request)
data=url_response.read().decode('utf-8')
jpglist=re.findall('http.+?.mp4',data)
print('pnglist',jpglist)
n=1


for each in jpglist:
	
	print("str",each)
	try:
		request.urlretrieve(each,'/home/student/pc/MP4/%s.mp4' %n)
	except Exception as e:
		print(e)
	finally:
		print('this is num %s com' %n)
	n+=1
