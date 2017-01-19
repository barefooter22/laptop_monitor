#!/bin/bash
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[01;32m'
NC='\033[0m' # No Color
BATTPERCSTRING=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage')
BATTPERCSTRING=${BATTPERCSTRING::-1}
BATTPERC=${BATTPERCSTRING:21:23}
BATTLOW=40
BATTSTATESTR=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state')
BATTSTATE=${BATTSTATESTR:25}
while true
do
clear
BATTSTATESTR=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state')
BATTSTATE=${BATTSTATESTR:25}

echo "LAPTOP SYSTEM MONITOR"
echo -n -e "    CPU \t\t "
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
echo -n -e "    Memory \t\t "
free | awk 'FNR == 3 {printf $3/($3+$4)*100}'
echo -e "%"
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state'
# echo "$(($BATTPERCCROP + 100))"
if [ "$BATTPERC" -lt "$BATTLOW" ];then
	echo -e -n ${RED}${BOLD} #change the color of the text to RED
	upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage'
	echo -e ${NC} #change the color of the text back to WHITE (No Color)
else
	echo -e -n ${GREEN}${BOLD} #change the color of the text to RED
	upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage'
	echo -e ${NC} #change the color of the text back to WHITE (No Color)
fi

if [[ "$BATTPERC" -lt "$BATTLOW" && "$BATTSTATE" == "discharging" ]];then
	echo -e ${RED}${BOLD}"-------------------------------" #change the color of the text to RED
	echo -e "PLUG IN CHARGER!!!!!" #change the color of the text to RED
	echo -e "-------------------------------"${NC} #change the color of the text to RED
fi
sleep 3
done
