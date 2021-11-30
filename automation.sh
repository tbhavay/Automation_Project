#!/bin/bash

myname="bhavvaya"
s3_bucket="upgrad-bhavvaya"

sudo apt update -y
apache_check=$(dpkg --get-selections | grep apache2| awk '{print $1}')
if [[ "$apache_check" =~ .*"apache2".* ]]; then
  echo "The Apache Server is installed"; 
else
	echo "now installing apache 2"
	apt-get install apache2 -y
fi

apacheserverService=$(systemctl list-unit-files | grep apache2.service | awk '{print $2}')
if [[ $apacheserverService = "enabled" ]];then
	echo "Apache server service is already configured "
else
	systemctl start apache2.service
	echo "Apache2 server service has been enabled"
fi
ApacheServiceStatus="$(systemctl is-active apache2.service)"
if [ "${ApacheServiceStatus}" != "active" ]; then
	sudo systemctl start apache2.service
fi
timestamp=$(date '+%d%m%Y-%H%M%S')
cd /var/log/apache2/
filename=$myname"-httpd-logs-"$timestamp
tar -cf ${filename}.tar *.log
aws s3 cp ${filename}.tar s3://${s3_bucket}/${filename}.tar

invent_file="/var/www/html/inventory.html"

if ! [ -f $invent_file ]
then
        touch $invent_file
        echo "<h><b>Log Type &ensp;&ensp;  Date Created  &ensp;&ensp; Type &ensp;&ensp; Size" > $invent_file
fi
size=$(ls -lh | grep "$filename" | awk '{print $5}')
echo "<p>httpd-logs &ensp;&ensp; $timestamp &ensp;&ensp; tar &ensp;&ensp; $size</p>" >> $invent_file

if  [ ! -f  /etc/cron.d/automation ]
then
	echo  "0 18 * * * \troot\t/root/Automation_Project/automation.sh" > /etc/cron.d/automation
fi


