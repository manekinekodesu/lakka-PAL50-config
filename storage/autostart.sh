#!/bin/bash

ispal=$(tvservice -s | grep -c "PAL")
isntsc=$(tvservice -s | grep -c "NTSC")
is50=$(tvservice -s | grep -c "50.00Hz")
is60=$(tvservice -s | grep -c "60.00Hz")
ispal50=$((is50+ispal))
ispal60=$((is60+ispal+isntsc))

if [ "$ispal50" -ge "2" ]; then  
	ln -sf /storage/.config/retroarch/retroarch.cfg.pal50 /storage/.config/retroarch/retroarch.cfg
	mount -o bind /storage/.config/retroarch/config.pal50 /storage/.config/retroarch/config
	echo "composite 50" > /storage/.config/mode.txt
elif [ "$ispal60" -ge "2" ]; then
	ln -sf /storage/.config/retroarch/retroarch.cfg.pal60 /storage/.config/retroarch/retroarch.cfg
	mount -o bind /storage/.config/retroarch/config.pal60 /storage/.config/retroarch/config
	echo "composite 60" > /storage/.config/mode.txt
else
	ln -sf /storage/.config/retroarch/retroarch.cfg.default /storage/.config/retroarch/retroarch.cfg
	mount -o bind /storage/.config/retroarch/config.default /storage/.config/retroarch/config
	echo "default" > /storage/.config/mode.txt
fi