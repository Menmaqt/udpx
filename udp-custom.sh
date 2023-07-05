#!/bin/bash

cd
rm -rf /root/udp
mkdir -p /root/udp

# install udp-custom
echo ""
sleep 4
echo " Install UDP-CUSTOM........" | lolcat
sleep 4
clear
echo "Waiting For Installing....." | lolcat
clear
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://raw.githubusercontent.com/Menmaqt/udpx/main/udp-custom-linux-amd64" -O /root/udp/udp-custom && rm -rf /tmp/cookies.txt
chmod +x /root/udp/udp-custom

# install Config Default Udp
echo ""
echo "Preparing To Install Default Config...." | lolcat
sleep 4
clear
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://raw.githubusercontent.com/Menmaqt/udpx/main/config.json" -O /root/udp/config.json && rm -rf /tmp/cookies.txt
chmod 644 /root/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by zxmenma

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by zxmenma

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

echo start service udp-custom
systemctl start udp-custom &>/dev/null

echo enable service udp-custom
systemctl enable udp-custom &>/dev/null


echo ""
sleep 0,5
clear