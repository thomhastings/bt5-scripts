'''
Author: kaneda (kanedasan@gmail.com)
Date: Feb 4th 2013
Description: Expansible broad-range http(s) directory traversal vuln scanner

Copyright (c) 2013 kaneda (http://josh.myhugesite.com)
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met: 

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Don't be evil. 
'''

import urllib2
from random import random
import sys
from socket import socket
import threading

# Feel free to add vulns here
vuln_exts=["",]

# Without http proxies this will crash!
http_proxies = ["",]

# Without https proxies this will crash!
https_proxies = ["",]

static_test = 'google.com'

class AttackClass(threading.Thread):
	def __init__(self,ips):
		super(AttackClass, self).__init__()
		self.good_ips = ips
		self.res = []
		self.setupProxy("http",True)
		self.isPlain = True

	def setupProxy(self,scheme,isPlain):
		# First try
		if(isPlain): url = http_proxies[int(random()*len(http_proxies))]
		else: url = https_proxies[int(random()*len(https_proxies))]
		proxy_support = urllib2.ProxyHandler({scheme : url} )
                opener = urllib2.build_opener(proxy_support)
                urllib2.install_opener(opener)
		
		while(True):
			try:
				urllib2.urlopen(scheme+"://"+static_test,timeout = 0.1)
				break
			except Exception:
				if(isPlain): url = http_proxies[int(random()*len(http_proxies))]
				else: url = https_proxies[int(random()*len(https_proxies))]
				proxy_support = urllib2.ProxyHandler({scheme : url} )
		                opener = urllib2.build_opener(proxy_support)
                		urllib2.install_opener(opener)

	# Just try 80 and 443
	# Returns the scheme or None
	def openPort(self,url):
		s = socket()
		s.settimeout(0.1)
		try:
			s.connect((url,80))
			s.shutdown(2)
			s.close()
			return "http://"+url
		except Exception:
			try:
				s.connect((url,443))
				s.shutdown(2)
				s.close()
				self.setupProxy("https",False)
				return "https://"+url
			except Exception:
				pass
		return None

	# Tests to see if a URL returns 200 OK
	def exists(self,url):
		try: urllib2.urlopen(url,timeout = 0.1)
		except Exception: return False
		return True

	# This one tests to see if there's a content-length and it's non-zero
	def existsNotEmpty(self,url):
                try:
			u = urllib2.urlopen(url,timeout = 0.1)
			if(not u or 'content-length' not in u.info() or u.info()['content-length'] == 0): return False
                except Exception: return False
                return True

	def run(self):
		for ip in self.good_ips:
	                schemeUrl = self.openPort(ip)
	                #print "Testing",ip,": ",schemeUrl
	                if(schemeUrl):
	                        # try a preliminary test, if the result is a 403 retry HTTPS
	                        try:
					isHttps = "https" in schemeUrl and schemeUrl.index("https") == 0
					if(isHttps and self.isPlain):
                                                self.setupProxy("https",False)
						self.isPlain = False
					elif(not isHttps and not self.isPlain):
				                self.setupProxy("http",True)
						self.isPlain = True
	                                urllib2.urlopen(schemeUrl,timeout = 0.1)
	                        except urllib2.HTTPError, err:
	                                if err.code == 404:
	                                        pass
	                                elif err.code == 403:
	                                        schemeUrl = "https://"+ip
						if(self.isPlain):
							self.setupProxy("https",False)
							self.isPlain = False
	                                else:
	                                        continue
	                        except Exception, e:
	                                continue
	
	                        print "Found a viable IP: ",schemeUrl
	                        for ext in vuln_exts:
					url = schemeUrl+ext
	                                if(self.existsNotEmpty(url)):
	                                        print "Found possible vuln at ",url
	                                        self.res.append(url)

def genRange(start,end):
	low_sects = []
	high_sects = []
	try:
		low_sects = [ int(x) for x in start.split('.') ]
		high_sects = [ int(x) for x in end.split('.') ]
		l_len = len(low_sects)
		if(l_len != 4 or l_len != len(high_sects)): raise Exception('yikes')
	except Exception:
		print "That doesn't look like a valid IP"
		return None

	if(low_sects[0] != high_sects[0]): print "You've selected to generate a lot of IPs, this might take a while"

	if(low_sects[0] > high_sects[0] or low_sects[1] > high_sects[1] or low_sects[2] > high_sects[2] or low_sects[3] > high_sects[3]):
		print "All of the sections of the lower range must be lower than the upper range"
		return None

	if(high_sects[0] > 254 or high_sects[1] > 254 or high_sects[2] > 254 or high_sects[3] > 254):
		print "One of your upper ranges is beyond the limit of IPv4"
		return None

	return [ str(la)+"."+str(lb)+"."+str(lc)+"."+str(ld) for la in range(low_sects[0],high_sects[0]+1) for lb in range(low_sects[1],high_sects[1]+1) for lc in range(low_sects[2],high_sects[2]+1) for ld in range(low_sects[3],high_sects[3]+1) ]

def main():
	if(len(sys.argv) < 3):
		print "Usage: cgi-scanner.py <LOWER_RANGE> <UPPER_RANGE> <THREADS*>\nExample: cgi-scanner.py 10.0.0.1 10.0.254.254 2\nNumber of threads is 2 by default"
		return None
	
	numThreads = 2
	if(len(sys.argv) == 4):
		try:
			numThreads = int(sys.argv[3])
			if(numThreads < 1): raise Exception('yikes')
		except Exception:
			print "Not a valid number of threads, using 2 instead"

	res = []
	good_ips = genRange(sys.argv[1],sys.argv[2])
	ip_len = len(good_ips)
	print "Finished generating", ip_len,"IPs, beginning scan"
	bucket_size = ip_len / numThreads
	job_list = []
	for i in range(numThreads-1):
		ip_section = good_ips[i*bucket_size:(i+1)*bucket_size]
		job_list.append(AttackClass(ip_section))
	last_section = good_ips[bucket_size*(numThreads-1):]
	job_list.append(AttackClass(last_section))

	for j in job_list:
		j.start()

	for j in job_list:
        	j.join()
		res += j.res
	return res

res = main()
print "Vulns found: ",res
