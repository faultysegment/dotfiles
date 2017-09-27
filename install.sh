#!/bin/sh
python -c "exit(0)"
if [ $? -ne 0 ]
then
    echo "Need to install Python"
    grep -q "DISTRIB_ID=[a-zA-Z]*buntu" /etc/lsb-release
    if [ $? -eq 0 ]
    then
        apt install python
    else
        exit 1
    fi
fi
python3 ./install.py
pip3 install neovim
pip3 install python-language-server
