#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "[-] Please run as root" 
   exit 1
fi
clear
echo "Installing now..."

sudo apt install spooftooph 
