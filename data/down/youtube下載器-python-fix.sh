#! /bin/bash

# Script Author:HYDeReUb(GitHub) Version: 1.1 Day

while true; do
 echo "您好，這是youtube-dl下載器"
 echo ""
 echo "使用代號:[D]下載 [U]更新 [I]安裝 [Q]離開"
 read -n 1 -p "請選擇代號:" ch
    case $ch in
        [Ii]* ) echo "" && echo "" && sudo apt install youtube-dl && echo "" && read -p "安裝完成，按[Enter]結束" && clear;;
        [Uu]* ) echo "" && echo "" && sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl  &&  sudo chmod a+rx /usr/local/bin/youtube-dl && youtube-dl -U && echo "" && read -p "完成，按[Enter]結束更新" && clear;;
        [Dd]* ) echo "" && echo "" && echo "終端機貼上方式:[Ctrl]+[Shift]+[V]" && echo "下載位置: 家目錄/youtube下載" && read -p "請輸入網址:" url && read -p "請輸入檔名(不要有空格，且不要輸入副檔名):" fname && normal='~/youtube下載/' && python3 $(which youtube-dl) -o $normal$fname $url && echo "" && read -p "完成，按[Enter]結束下載" && clear;;
        [Qq]* ) exit;;
        * ) echo "" && echo "" && echo "/////輸入錯誤，請重新選擇/////" && echo "";;
    esac
done
