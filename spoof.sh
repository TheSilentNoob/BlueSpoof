#!/bin/bash

RED="\e[31m"
BLUE="\e[94m"
GREEN="\e[92m"

function banner(){ 
clear
printf "${BLUE}"
figlet -w 200 -f standard "BlueSpoof"

echo "

	1. Scan for Bluetooth devices MAC adress
	2. Start Spoofing bluetooth device 
	3. Get Bluetooth Device Infos
	4. Exit

"
read -p "BlueSpoof > : " input

}

while :
do
  banner
  if [ "$input" == 1 ]; then
    service bluetooth start
    sleep 4 
    hcitool scan
    read -p "Whats your target bt device MAC > : " bt_mac
    read -p "Would you spoof now [Y/N]" answer
    if [[ $answer == "y" || $answer == "Y" || $answer == "yes" || $answer == "Yes" ]]; then
      spooftooph -a "$bt_mac"
      service bluetooth restart
      sleep 3
      hciconfig
    elif [[ $answer == "n" || $answer == "N" || $answer == "no" || $answer == "No" ]]; then
      printf "${GREEN}"
      echo "GoodBye :)"
    else
      printf "${RED}"
      echo " ERROR : Not available option ! "
    fi
  elif [ "$input" == 2 ]; then
    read -p "What bt device MAC would you spoof ? > : " bt_mac
    spooftooph -a "$bt_mac"
    service bluetooth restart
    sleep 4
    hciconfig
  elif [ "$input" == 3 ]; then
    read -p "Already have MAC addr or scan ? [Y/scan]" ask_inf
    if [ "$ask_inf" == "Y" ]; then
      read -p "What is the MAC > : " mac_addr
      hcitool info "$mac_addr"
    elif [ "$ask_inf" == "scan" ]; then
      hcitool scan
      read -p "For which MAC do you want infos > : " mac_addr
      hcitool info "$mac_addr"
    fi  
  elif [ "$input" == 4 ]; then
    printf "${GREEN}"
    echo "Good Bye ;) "
    exit
  elif [ "$input" -gt 4 ]; then
    printf "${RED}"
    echo "This is not a available option :("
    sleep 2
  fi
done
