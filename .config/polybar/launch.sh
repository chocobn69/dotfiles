#!/usr/bin/env sh

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar -m|sed -e 's/:.*//g')
do
    MONITOR=$m polybar -r bottom -q &
    MONITOR=$m polybar -r top -q &
done
