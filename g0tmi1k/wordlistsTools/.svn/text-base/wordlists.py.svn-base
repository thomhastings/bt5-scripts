#!/usr/bin/python
#----------------------------------------------------------------------------------------------#
#wordlists.py v0.2 (#1 2010-09-28)                                                             #
# (C)opyright 2010 - g0tmi1k                                                                   #
#---Important----------------------------------------------------------------------------------#
#                     *** Do NOT use this for illegal or malicious use ***                     #
#                         YOU are using this program at YOUR OWN RISK.                         #
#             This software is provided "as is" WITHOUT ANY guarantees OR warranty.            #
#---Modules------------------------------------------------------------------------------------#
import array, sys, time, random, os

#---Defaults-----------------------------------------------------------------------------------#
output = "output.lst"   # Filename to save as

#---Variables----------------------------------------------------------------------------------#
version = "0.2 #1"         # Program version
cruch = "/pentest/passwords/crunch/crunch"
debug = False              # Doesn't delete files, shows more on screen etc
i = 0                      # null the value
totalFiles = 0             # null the value
files = ""                 # String of all the files
filename = []              # Loads files via aguments at comamnd line
array = []                 # For file
array_dupfree = []         # for array, checks to see ifs its in before.
array_dup = {}             # for array, if its been used, put it here.
action = "\033[32m[>]\033[0m "
info = "\033[33m[i]\033[0m "
diag = "\033[34m[+]\033[0m "
error = "\033[31m[!]\033[0m "
for arg in sys.argv:
    filename.append(arg)

#----Functions---------------------------------------------------------------------------------#
def convert(mode):
   if mode == '1':    #Convert wordlist rainbow/hash tables (WPA)
      print "Coming Soon\n\n\n\n\n"
   elif mode == '2':  #Convert wordlist to 1337 (leet)
      print "Coming Soon\n\n\n\n\n"
   elif mode == '3':  #Alter wordlist by changing case (lower, upper or first letter)
      print "Coming Soon\n\n\n\n\n"
   return
#----------------------------------------------------------------------------------------------#
def generate(mode):
   if mode == '1':  #Generate Password
      while 1==1:
         genType = raw_input("""\n1.) alphanum\n2.) alpha\n3.) alphacap\n4.) all\n[~] Which type?: """)
         if (genType.isdigit() == False): print error+"Bad input\n"
         break
      while 1==1:
         genLength = raw_input("""[~] Length of password: """)
         if (genLength.isdigit() == False): print error+"Bad input\n"
         break

      passwd = ""
      alphanum = ('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')
      alpha = ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')
      alphacap = ('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
      all = ('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_+=~`[]{}|\:;"\'<>,.?/')

      if str(genType).lower() == "1":
         genType = alphanum
      elif str(genType).lower() == "2":
         genType = alpha
      elif str(genType).lower() == "3":
         genType = alphacap
      elif str(genType).lower() == "4":
         genType = all
      print info+"Password: "+passwd.join(random.sample(genType, int(genLength)))

   elif mode == '2':  #Generate wordlists
      num =('0123456789')
      alphLower = ('abcdefghijklmnopqrstuvwxyz')
      alphUpper = ('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
      alphHex = ('0123456789ABCDEF')
      special = ('!@#$%^&*()-_+=~`[]{}|\:;"\'<>,.?/')

      genNum = "Yes"
      genAlpha = "Both"
      genSpecial = "*Disabled*"
      genCustom = ""
      genBlockStart = ""
      genBlockEnd = ""
      genPad = "*Disabled*"
      genMinLength = "8"
      genMaxLength = "13"
      char = num + alphLower + alphUpper
      command = ""

      while 1==1:
         genSelect = raw_input("""
-Charset---------------------------------------------
      Numbers: """+genNum+"""
      Alpha: """+genAlpha+"""
      Special: """+genSpecial+"""
      Custom charset: """+genCustom+"""
-Starting/Ending-------------------------------------
      Starting Block: """+genBlockStart+"""
      End Block: """+genBlockEnd+"""
-Current charset-------------------------------------
"""+char+"""
-Settings--------------------------------------------
      Padding: """+genPad+"""
      Min Length: """+genMinLength+"""
      Max Length: """+genMaxLength+"""
-----------------------------------------------------
Options
      1.) Numbers
      2.) Alpha
      3.) Special
      4.) Custom charset
      5.) Starting Block
      6.) End Block
      7.) Padding
      8.) Mix Length
      9.) Max Length

      s.) Select
      x.) Return to Main menu

[~] Select: """)
         if (genSelect == "1"):
            if (genNum == "Yes"): genNum = "*Disabled*"
            else: genNum = "Yes"
         elif (genSelect == "2"):
            if (genAlpha == "lower"): genAlpha = "UPPER"
            elif (genAlpha == "UPPER"): genAlpha = "Both"
            elif (genAlpha == "Both"): genAlpha = "HEX"
            elif (genAlpha == "HEX"): genAlpha = "*Disabled*"
            else: genAlpha = "lower"
         if (genSelect == "3"):
            if (genSpecial == "Yes"): genSpecial = "*Disabled*"
            else: genSpecial = "Yes"
         if (genSelect == "4"):
            genCustom = raw_input("Custer Char: ")
         elif (genSelect == "5"):
            genBlockStart = raw_input("Start Block: ")
         elif (genSelect == "6"):
            genBlockEnd = raw_input("End Block: ")
         elif (genSelect == "7"):
            genPad = raw_input("Padding: ")
	    if (genPad == ""): genPad = "*Disabled*"
         elif (genSelect == "8"):
            genMinLength = raw_input("Min Length: ")
         elif (genSelect == "9"):
            genMaxLength = raw_input("Max Length: ")
         elif (genSelect == "s"): break
         elif (genSelect == "x"): return

         char = ""
         if (genNum == "Yes"): char = char+num
	 if (genAlpha == "lower"): char = char+alphLower
	 if (genAlpha == "UPPER"): char = char+alphUpper
         if (genAlpha == "Both"): char = char+alphLower+alphUpper
	 if (genAlpha == "HEX"): char = char+alphHex
	 if (genSpecial == "Yes"): char = char+special
	 char = char+genCustom

      command = cruch+ " "+genMinLength+" "+genMaxLength+" "+ char
      if (genBlockStart != ""): command=command+" -s "+genBlockStart
      command=command+" -o "+output
      print action+"Starting"
      os.system (command)
      print action+"Done!"

   elif mode == '3':  #Generate Custom Wordlists ('PaulDotCom' method)
      url = raw_input("""[~] URL?: """)
      print ("wget -r -l 2 "+url)
      print ("grep -hr "" "+url+"/ | tr '[:space:]' '\n' | sort | uniq > /tmp/wordlist.lst")
      print ("egrep -v '('\,'|'\;'|'\}'|'\{'|'\<'|'\>'|'\:'|'\='|'\"'|'\/'|'\/'|'\['|'\]')' /tmp/wordlist.lst | sort -u > /tmp/wordlist.clean.lst")
      print ("cat /tmp/password.lst >> /tmp/wordlist.clean.lst")
      print ("/pentest/passwords/jt/john --wordlist=/tmp/wordlist.clean.lst --rules --stdout | uniq > /tmp/final.wordlist.lst")
   return
#----------------------------------------------------------------------------------------------#
def removeDup (mode):
    array_dupfree = [] # for array, checks to see ifs its in before.
    array_dup = {}     # for array, if its been used,put it here.
    i = 0
    percentage = 0     # Where we are on the percent
    total = len(array)
    onePercentage = total / 100
    print "\n\n--------------------------"
    #print "Starting at:", time.strftime("%I:%M:%S %p", time.localtime())
    print info+"Total words:", total
    print "--------------------------"
    start = time.clock()
    file_write = open(output,"w")
    for element in array:
        i = i + 1
        if i == onePercentage:
            i = 0
            percentage = percentage + 1
            print percentage * onePercentage ,"words -", percentage,"%"
        if ((element + "\n") in array_dupfree) or ((element + "\n") in array_dup):  # Check to see if we have had the word before
            array_dup[element  + "\n"] = array.count(element)      # We have, lets make a note of it.
            if ((element + "\n") in array_dupfree): array_dupfree.remove(element  + "\n")
            if debug == True: print element , "is duplicated," , array.count(element) , "times."
        else:
            array_dupfree.append(element + "\n")             # Havent had it, so lets record it
            if mode == '1': file_write.write(element + "\n") # Save it to our word list now (UNSORTED)

    if mode == '2': #Remove dups + Sorts 0
        array_tmp = ""
        file_write.writelines (array_tmp.join(sorted(array_dupfree + array_dup.keys())))

    if mode == '3': #Remove dups + Higher the dups, higher the list
        file_write.writelines (sorted(array_dup))
        file_write.writelines (array_dupfree)

    if mode == '4': #Remove dups + Higher the dups, higher the list + sorts the rest 0-Z
        file_write.writelines (sorted(array_dup))
        file_write.writelines (sorted(array_dupfree))

    file_write.close()
    end = time.clock()

    print "\n"+info+"         Time taken:", end - start, "seconds."
    print info+"    Total wordlists:", totalFiles
    print info+"        Total words:", len(array)
    print info+" Total unique words:", len(array_dupfree)
    print info+"Number of dup words:", len(array_dup)
    print "\n"+action+"~Done!~\n\n\n\n\n"
    return
#----------------------------------------------------------------------------------------------#
def updateScript():
   from urllib2 import Request, urlopen, URLError, HTTPError

   print action+"Updating..."
   url = "http://g0tmi1k.googlecode.com/svn/trunk/wordlists/wordlists.py"
   req = Request(url)
   try:
      f = urlopen(req)
      local_file = open("wordlists.py", "w")
      local_file.write(f.read())
      local_file.close()
      print action+"Updated! (="
   except HTTPError, e:
      print error+"Failed. HTTP Error:",e.code , url
   except URLError, e:
      print error+"Failed. URL Error:",e.reason , url
   sys.exit(0)


#---Main---------------------------------------------------------------------------------------#
print "\033[36m[*]\033[0m wordlists v"+version

if debug == True:
    print info+"Debug mode: On"
    print "-----------------------------------------------------"
    
for file in filename[1:]:
    try:
        file_open = open(file,"r")
        print action+"Loading file: " + file
        totalFiles = totalFiles + 1
        if files != "": files = files + ", " + file
        else: files = file
        for word in file_open.readlines():
            array.append(word.strip()) # Removes EOL
            file_open.close()
    except IOError, err:
        print error+"Cant find file: " + file

try:
    while 1==1:
        print """-----------------------------------------------------\nMain Menu:\n-----------------------------------------------------
    1.) Remove duplicates form a wordlist
    2.) Remove duplicates + sort alphabetical order [0-Z]
    3.) Remove duplicates + Higher the dups, higher the list
    4.) Remove duplicates + Higher the dups, higher the list + sorts the rest alphabetical order [0-Z]\n-----------------------------------------------------
    5.) Generate Password
    6.) Generate wordlists
   *7.) Generate wordlists ('PaulDotCom' method)\n-----------------------------------------------------
   *8.) Convert wordlist rainbow/hash tables (WPA)
   *9.) Convert wordlist to 1337 (leet)
   *0.) Alter wordlist by changing case (lower, upper or first letter)\n-----------------------------------------------------
   *a.) Add/remove wordlists
   *m.) Merge wordlists (%s)
   *c.) Change output wordlist (%s)\n-----------------------------------------------------
    x.) Exit\n""" % (files, output)
        mainmenu = raw_input("""[~] Select option: """)
        sys.stdout.flush()
        if mainmenu == '1':
            removeDup ("1")
            pass
        elif mainmenu == '2':
            removeDup ("2")
            pass
        elif mainmenu == '3':
            removeDup ("3")
            pass
        elif mainmenu == '4':
            removeDup ("4")
            pass
        elif mainmenu == '5':
            generate ("1")
            pass
        elif mainmenu == '6': # Doesn't yet work!
            generate ("2")
            pass
        elif mainmenu == '7': # Doesn't yet work!
            generate ("3")
            pass
        elif mainmenu == '8': # Doesn't yet work!
            convert ("1")
            pass
        elif mainmenu == '9': # Doesn't yet work!
            convert ("2")
            pass
        elif mainmenu == '0': # Doesn't yet work!
            convert ("3")
            pass
        elif mainmenu.lower() == 'a': # Doesn't yet work!
            pass
        elif mainmenu.lower() == 'm': # Doesn't yet work!
            pass
        elif mainmenu.lower() == 'c': # Doesn't yet work!
            pass
        elif mainmenu.lower() == 'x':
            print "\033[36m[*]\033[0m Done! (= Have you... g0tmi1k?"
            sys.exit()

except KeyboardInterrupt :
    print "\n\n"+action+"  Exiting...\n\033[36m[*]\033[0m Done! (= Have you... g0tmi1k?"
    sys.exit()

#http://www.backtrack-linux.org/forums/old-pentesting/4336-%3Dxploitz%3D-thread-share-wordlist.html
#http://dragon-online.net/category/security/
#leet = http://forums.remote-exploit.org/programming/24070-wordlist-leetify-supplimenting-cupp-others.html
#pauldotcom = http://pauldotcom.com/2008/11/creating-custom-wordlists-for.html


#WPA Defaluts
# BTHomeHub2-xxxx = 10 lower hex
# SKYxxxxx v1 = 8 upper A-Z (netgear)
# SKY v2 = 8 upper A-Z (Netgear)
# SKY v3 = 8 upper A-Z (Sagem)

# Livebox-xxxx = 26 Length (Hexadecimal)???
# virginmedia =
# O2 =
# BTHomeHub =
# OrangeAB12C3

#http://cm9.net/skypass/
#nickkusters.com/SpeedTouch.aspx
#http://www.gnucitizen.org/blog/default-key-algorithm-in-thomson-and-bt-home-hub-routers/
