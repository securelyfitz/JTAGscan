#!/bin/bash
# 1. detect device attached
# 2. reset device with 1200 baud connection
# 3. flash device
# 4. on to the next one

BOSSAC="/opt/arduino-1.8.15/portable/packages/Seeeduino/tools/bossac/1.7.0-arduino3/bossac"
BOSSAC="/home/joefitz/Documents/3dprinters/klipper/lib/bossac"
BOSSAC="bossac"


while true
do
#	test -c /dev/ttyACM0 && echo "device found, resetting...." && sleep .1 && stty -F /dev/ttyACM0 1200 && sleep 2 && $BOSSAC -i -d --port=ttyACM0 -U true -i -e -w -v JTAGscan.ino.bin -R && spd-say "next" && echo "********
	test -c /dev/ttyACM0 && echo "device found, resetting...." && sleep .1 && stty -F /dev/ttyACM0 1200 && sleep 2 && $BOSSAC -i -d -e -o 8192 -w -v JTAGscan.ino.bin -R && spd-say "next" && echo "********
NEXT
*********" && sleep 2 || sleep .1
done
