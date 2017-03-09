#!/bin/bash

# libevent-2.1.so.6; may change according to the installed libevent 
obj=`tmux 2>&1 | tee | cut -d ':' -f 3 | sed 's/^ *//g'`

# location where the libevent lib installed
location=`find / -name $obj | sed -n '1p'`

# judge the system whether x64 or x32
uname -a | grep x86_64

if [ $? -eq 0 ];
then
    destination=/usr/lib64/$obj
else
    destination=/usr/lib/$obj
fi

ln -s $location $destination
