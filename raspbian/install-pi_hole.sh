#installs a pi-hole on a raspberry pi exposed through pivpn
#run this script as root


#ask the user if they want to configure wifi
echo "Do you want to configure wifi? (y/n)"
read wifi
if [ $wifi = "y" ]
then
    #run the setup-wifi script
    chmod +x ./setup-wifi.sh
    ./setup-wifi.sh
fi


#ask the user if they wish to fix the rtl8188eu driver
echo "Do you wish to fix the rtl8188eu driver? (y/n)"
read fixdriver
if [ $fixdriver = "y" ]
then
    chmod +x ./fix-rtl8188eu.sh
    #run the fix-rtl8188eu script
    ./fix-rtl8188eu.sh
fi


#ask the user if they wish to reset dhcpcd, wpa_supplicant, and hostapd
echo "Do you wish to reset dhcpcd, wpa_supplicant, and hostapd? (y/n)"
read reset
if [ $reset = "y" ]
then
    #restart the dhcpcd service
    systemctl restart dhcpcd

    #restart the wpasupplicant service
    systemctl restart wpa_supplicant

    #reset the wifi interface
    wpa_cli -i wlan0 reconfigure
fi



#print the wifi ip address
echo "Your wifi ip address is:"
ip addr show wlan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1

#ask the user if he wants to install pi-hole
echo "Do you want to install pi-hole? (y/n)"
read pihole
if [ $pihole = "y" ]
then
    #install pi-hole
    curl -sSL https://install.pi-hole.net | bash
fi

#ask the user if he wants to install pivpn
echo "Do you want to install pivpn? (y/n)"
read pivpn
if [ $pivpn = "y" ]
then
    #install pivpn
    curl -L https://install.pivpn.io | bash
fi
