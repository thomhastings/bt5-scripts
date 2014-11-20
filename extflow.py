#!/usr/bin/env python

# extflow.py v.2 created by alexander.hanel@gmail.com
# This is a simple script that will carve out files
# from streams created by tcpflow.

# find ../ -name 'dump.pcap' -exec ./ext-flow.py {} \; 

import hashlib
import os.path
import sys
import re
from StringIO import StringIO
import subprocess as sub

def MD5(d):
# d = buffer of the read file 
# This function hashes the buffer
# source: http://stackoverflow.com/q/5853830
    if type(d) is str:
      d = StringIO(d)
    md5 = hashlib.md5()
    while True:
        data = d.read(128)
        if not data:
            break
        md5.update(data)
    return md5.hexdigest()

def check_tcpflow_ver():
    p = sub.Popen(['tcpflow', '-V'], stdout=sub.PIPE, stderr=sub.PIPE)
    out = p.communicate()[0]
    # for longevity reasons, this is crappy logic to check for the version 
    if 'tcpflow 1.' not in out and 'tcpflow 2.' not in out:
        print "\t[ERROR] Please download 1.0 or higer"
        print "\tDownload: https://github.com/simsong/tcpflow/"
        sys.exit(1)

def ext(header):
    # To add a new signature add your own elif statement
    #    elif 'FILE SIGNATURE' in header:
    #    return 'FILE EXTENSION'
    if 'MZ' in header:
        return '.mz'
    elif 'FWS' in header:
        return '.swf'
    elif 'CWS' in header:
        return '.swf'
    elif 'html' in header:
        return '.html'
    elif '\x50\x4B\x03\x04\x14\x00\x08\x00\x08' in header:
        return '.jar'
    elif 'PK' in header:
        return '.zip'
    elif 'PDF' in header:
        return '.pdf'
    else:
        return '.bin'     
    
def parse_out_data(f_handle):
    parsed_data = []
    data = f_handle.read()
    if len(data):
        addr_http_200 = [tmp.start() for tmp in re.finditer('HTTP/1\.1 200 OK',data)]
        if len(addr_http_200) == 0:
            # return if single file in stream
            parsed_data.append(data)
            return parsed_data
        
        # multiple files in the stream 
        else:
            # get first file located at addr 0
            index = 0
            #for x in addr_http_200: print hex(x),
            #print      
            for c, addr in enumerate(addr_http_200):
                # index = start, addr is the next HTTP/1.1 200 OK
                parsed_data.append(data[index:addr-2])
                newline_addr = data[addr:-1].find('\x0d\x0a\x0d\x0a')
                index = addr + (newline_addr + 4)
                if c+1 == len(addr_http_200):
                    parsed_data.append(data[index:-2])
                    
            return parsed_data
    else:
        # length is zero no data to parse out 
        return None 
    
	
def main():
    check_tcpflow_ver()
    try:
        with open(sys.argv[1]) as f: pass
    except Exception:
        print "\t[ERROR] File could not be accessed"
        sys.exit(1)
    p = sub.Popen(['tcpflow', '-o', 'tcpflow_out','-AH', '-r', sys.argv[1]], stdout=sub.PIPE, stderr=sub.PIPE)
    p.wait()
    dire = os.path.join(os.getcwd() + '/tcpflow_out/')
    for infile in os.listdir(dire):
        f = open(dire + infile, 'rb')
        if 'HTTPBODY' not in infile:
            continue
        parsed_results = parse_out_data(f)
        if parsed_results == None:
            continue 
        else:
            for emb_files in parsed_results:
                ex = ext(emb_files[:20])
                if 'bin' in ex:
                    continue
                o = open(MD5(emb_files)+ex,'wb')
                o.write(emb_files)
                o.close()
        
if __name__ == '__main__':
   main()
