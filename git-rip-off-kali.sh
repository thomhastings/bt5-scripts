for LINE in `curl http://git.kali.org/gitweb/?a=project_index | sort`
do
	if [ ! -e "tails/kali/`echo $LINE | awk -F. '{print $1}'`" ]
	then
		git clone git://git.kali.org/$LINE
	else
		cd $LINE
		git pull
		cd ..
	fi
done

