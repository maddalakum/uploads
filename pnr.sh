#Copyright By kumar Raja
BBlack="\033[1;30m" # Black
BRed="\033[1;31m" # Red
BGreen="\033[1;32m"
BYellow="\033[1;33m" # Yellow
BBlue="\033[1;34m" # Blue
BPurple="\033[1;35m" # Purple
BCyan="\033[1;36m" # Cyan
BWhite="\033[1;37m" # White
none="\033[0m"
bold="\033[1m"
red="\033[0;31m"
if [ $1 ] ; then
#LD_LIBRARY_PATH=/system/lib64

curl -s "http://www.railyatri.in/pnr-status/$1" > /sdcard/pnrcheck
TRAINNAME=`cat /sdcard/pnrcheck | grep -A1 '"/time-table/' | sed 's/<.*>//g' | egrep -o '[a-z].*|[0-9].*'`
if [ "`echo $TRAINNAME |grep "." |  wc -c `" -gt 3 ]; then
FROM=`cat /sdcard/pnrcheck | grep -A3 FROM: | sed 's/<.*>//g' | egrep -io '[0-9].*|[a-z].*' | sed 's/ |.*//g'`
TO=`cat /sdcard/pnrcheck | grep -A3 TO: | sed 's/<.*>//g' | egrep -io '[0-9].*|[a-z].*' | sed 's/ |.*//g'`
BOARD=`cat /sdcard/pnrcheck | grep -A3 BOARD: | sed 's/<.*>//g' | egrep -io '[0-9].*|[a-z].*'`
CLASS=`cat /sdcard/pnrcheck | grep -A3 CLASS: | sed 's/<.*>//g' | egrep -io '[0-9].*|[a-z].*'`
CHART=`cat /sdcard/pnrcheck | grep -A3 CHART: | sed 's/<.*>//g' | egrep -io '[0-9].*|[a-z].*'`
NO=`cat /sdcard/pnrcheck | grep -A200 'BOOKING STATUS' | sed -n -e '/<td>/,/<\/table>/ p' | sed 's/<.*>//g' | egrep -io '[0-9].*|[a-z].*' | sed '1!d'`
CSTATUS=`cat /sdcard/pnrcheck | grep -A200 'BOOKING STATUS' | sed -n -e '/<td>/,/<\/table>/ p' | sed 's/<.*>//g' | egrep -io '[0-9].*|[a-z].*' | sed '2!d'`
BSTATUS=`cat /sdcard/pnrcheck | grep -A200 'BOOKING STATUS' | sed -n -e '/<td>/,/<\/table>/ p' | sed 's/<.*>//g' | egrep -io '[0-9].*|[a-z].*' | sed '3!d'`
echo "${BGreen}         ------------------------------"
echo "\t        ${BCyan}| ${bold}${BCyan}Train Name  |${none}"
echo "${BGreen}         ------------------------------"
echo "$TRAINNAME" |sed 's/ / /g'
echo ""
echo "\t      ${BYellow}Date of Journey:${BPurple}$BOARD${none}  "
echo ""
echo "${BYellow}Class:${BPurple}$CLASS\n${BYellow}Chart:${BPurple}$CHART${none}"
echo ""
echo "${BYellow}From Station:${BPurple}$FROM ${BYellow}To Station:${BPurple}$TO"
echo "${BGreen}         ------------------------------"
echo "\t${BYellow}   Current Status:\t ${BGreen}$CSTATUS${none}"
echo "\t${BYellow}   Booking Status:\t ${BGreen}$BSTATUS${none}"
echo "${BGreen}         ------------------------------${none}"
#LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
else
curl -s  "http://indiarailinfo.com/pnr/predform?p=$1" > /sdcard/pnrcheck
FROM=`cat /sdcard/pnrcheck  | sed 's/<input type.*//g' | sed 's/^.*<h2>//g' | tr -s '>' '\n' | sed -e 's/<.*//g' | sed '/^$/d' | grep "From.*"  | cut -d: -f2`
TO=`cat /sdcard/pnrcheck | sed 's/<input type.*//g' | sed 's/^.*<h2>//g' | tr -s '>' '\n' | sed -e 's/<.*//g' | sed '/^$/d' | grep "^To:.*"  | cut -d: -f2`
BOARD=`cat /sdcard/pnrcheck | sed 's/<input type.*//g' | sed 's/^.*<h2>//g' | tr -s '>' '\n' | sed -e 's/<.*//g' | sed '/^$/d' | grep "^Date of Journey:.*"  | cut -d: -f2-`
CLASS=`cat /sdcard/pnrcheck |sed 's/<input type.*//g' | sed 's/^.*<h2>//g' | tr -s '>' '\n' | sed -e 's/<.*//g' | sed '/^$/d' | grep "^Class:.*"  | cut -d: -f2`
CSTATUS=`cat /sdcard/pnrcheck | sed 's/<input type.*//g' | sed 's/^.*<h2>//g' | tr -s '>' '\n' | sed -e 's/<.*//g' | sed '/^$/d' | grep -A1 "Passenger"  | sed '2!d'`
BSTATUS=`cat /sdcard/pnrcheck | sed 's/<input type.*//g' | sed 's/^.*<h2>//g' | tr -s '>' '\n' | sed -e 's/<.*//g' | sed '/^$/d' | grep "Booking Status.*" | cut -d':' -f2 | sed -e 's/)//g'`
CHART=`cat /sdcard/pnrcheck |  sed 's/<input type.*//g' | sed 's/^.*<h2>//g' | tr -s '>' '\n' | sed -e 's/<.*//g' | sed '/^$/d' | grep "Chart.*" | cut -d' ' -f2-`
echo "${BGreen}       -----------------------------------${none}"
echo "\t${BYellow}Date of Journey:${BPurple}$BOARD${none}  "
echo "${BGreen}       -----------------------------------${none}"
echo "${BYellow}Class:${BPurple}$CLASS\n${BYellow}Chart: ${BPurple}$CHART${none}"
echo ""
echo "${BYellow}From Station:${BPurple}$FROM ${BYellow}To Station:${BPurple}$TO"
echo "${BGreen}         ------------------------------"
echo "\t${BYellow}   Current Status:\t ${BGreen}$CSTATUS${none}"
echo "\t${BYellow}   Booking Status:\t${BGreen}$BSTATUS${none}"
echo "${BGreen}         ------------------------------${none}"
#LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
fi
else
echo "${BRed}\tPNR Number Required${none}"
fi
