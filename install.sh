#!/bin/sh
grep -q "DISTRIB_ID=[a-zA-Z]*buntu" /etc/lsb-release
check_ubuntu=$?
which python
if [ $? -ne 0 ]
then
    echo "Need to install Python"
    if [ check_ubuntu -eq 0 ]
    then
        apt install python
    else
        exit 1
    fi
fi
python3 ./install.py
