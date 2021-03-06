#!/bin/bash

dades=$(echo $QUERY_STRING) 
cron=$(echo "$dades" | awk -F= '{print $2}')

cron=${cron::-5}

sudo echo $cron > tmp
sed -i 's/+/ /g' ./tmp
sed -i 's/%3E/>/g' ./tmp
sed -i 's/%22/"/g' ./tmp
sed -i 's/%2F/\//g' ./tmp
sed -i 's/*/\*//g' ./tmp

cronOk=$(sudo cat tmp)

$(sudo logger -i $cronOk task is going to be scheduled in the cron )

echo Content-Type: text/html
echo
echo -e "<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
	</head>
	<body>
	<h3>Scheduling new task</h3>
	<p>
	The command is: $cronOk
        </p>
        <form action='receiveLogin.sh'>
        	<input type='submit' value='Main menu'>
        </form>
	</body>
</html>
"
$(sudo chmod 777 /etc/crontab)
$(sudo echo -e "$cronOk" >> /etc/crontab)
$(sudo chmod 600 /etc/crontab)

$(sudo service cron restart)


