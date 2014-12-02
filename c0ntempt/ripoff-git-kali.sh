for LINE in `curl http://git.kali.org/gitweb/?a=project_index | sort`
do
	if [ ! -e "kali/`echo $LINE | awk -F. '{print $1}'`" ]
	then
		git clone git://git.kali.org/$LINE `echo $LINE | awk -F. '{print $1}'`
	else
		cd $LINE
		git pull
		cd ..
	fi
done
