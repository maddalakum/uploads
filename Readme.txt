Install termux from playstore 
Follow my Environment setup video 

install curl in termux by typing apt install curl
curl 'https://raw.githubusercontent.com/maddalakum/uploads/master/pnr.sh' > /sdcard/pnr.sh ; sh pnr.sh 4427595734

If curl not there install busybox or in termux apt install wget

wget -qO - 'https://raw.githubusercontent.com/maddalakum/uploads/master/pnr.sh' > /sdcard/pnr.sh ; sed 's/curl/wget -qO -/g' /sdcard/pnr.sh ; sh pnr.sh 4427595734
