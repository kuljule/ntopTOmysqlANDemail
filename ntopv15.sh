#!/bin/bash

username=""     # input username
password=""     # input password
database=""     # input database

wget -O '/home/mysqlv10/Downloads/ntopv15.xml' "http://192.168.3.254:3000/dumpData.html?language=xml&view=long"		# download the ntop data dump as an xml file
mysql -u $username -p$password $database < '/home/mysqlv10/ntopv15.txt'			# connect to mysql database and run commands in ntopv15.txt

# ntopv15.txt loads ntopv15.xml into a table called ntopv15
