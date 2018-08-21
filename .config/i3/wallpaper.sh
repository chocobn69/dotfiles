#!/bin/env sh
rm -f ~/Dropbox/wallpapers/bg-*
for i in 1 2
do
  wget https://wallhaven.now.sh/random?keyword=$1 -O ~/Dropbox/wallpapers/bg-$i.png  -q
done
feh --bg-fill ~/Dropbox/wallpapers
