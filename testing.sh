#!/bin/bash

# based on https://unix.stackexchange.com/questions/117037/how-to-send-data-to-a-serial-port-and-see-any-answer

if test -f ttyDump.dat; then
	rm ttyDump.dat
fi

while true
do
sleep .2
if test -c /dev/ttyACM0; then

stty -F /dev/ttyACM0 115200 raw -echo   #CONFIGURE SERIAL PORT
exec 3</dev/ttyACM0                     #REDIRECT SERIAL OUTPUT TO FD 3
cat <&3 > ttyDump.dat &          #REDIRECT SERIAL OUTPUT TO FILE
PID=$!                                #SAVE PID TO KILL CAT
cat uart-in > /dev/ttyACM0             #SEND COMMAND STRING TO SERIAL PORT
sleep 02s                          #WAIT FOR RESPONSE
kill $PID                             #KILL CAT PROCESS
wait $PID 2>/dev/null                 #SUPRESS "Terminated" output
exec 3<&-                               #FREE FD 3
#cat ttyDump.dat                    #DUMP CAPTURED DATA
diff ttyDump.dat uart-out > /dev/null
error=$?
#exit $error
if [ $error -eq 0 ]
then
	spd-say "next"
	echo "**********\nNext\n**********"
	#sleep 2
else
	#spd-say "error"
	echo "error, retrying"
	#diff ttyDump.dat uart-out                   #DUMP CAPTURED DATA
	cat ttyDump.dat                   #DUMP CAPTURED DATA
fi
rm ttyDump.dat

fi
done
