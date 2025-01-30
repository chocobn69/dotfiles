#!/bin/env sh
rm -f ~/Dropbox/wallpapers/bg-*
url=$(curl -s "https://wallhaven.cc/api/v1/search?sorting=random&q=type:png$1" | jq -r '.data[0].path')
wget $url -O ~/Dropbox/wallpapers/bg-1.png
