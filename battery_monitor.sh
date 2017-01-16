#!/bin/bash
while true
do
clear
echo "LAPTOP SYSTEM MONITOR"
echo -n -e "    CPU \t\t "
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
echo -n -e "    Memory \t\t "
free | awk 'FNR == 3 {printf $3/($3+$4)*100}'
echo -e "%"
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state'
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage'
sleep 3
done
