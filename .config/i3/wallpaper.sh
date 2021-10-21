#!/bin/env sh
rm -f ~/Dropbox/wallpapers/bg-*
url=$(curl -s "https://wallhaven.cc/api/v1/search?sorting=random&q=$1" | jq -r '.data[0].path')
wget $url -O ~/Dropbox/wallpapers/bg-1.jpg
swaymsg output HDMI-A-1 bg ~/Dropbox/wallpapers/bg-1.jpg stretch
