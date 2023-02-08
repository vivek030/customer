#!/bin/bash
sudo apt-get update
sudo apt-get install wireguard-tools
sudo apt install resolvconf
email="demokorplink@pacewisdom.com"
read -p 'Enter Friendly Name: ' id < /dev/tty
read -p 'Enter API Key: ' api < /dev/tty
json='{"Email":"'"${email}"'","Identifier":"'"${id}"'"}'
curl --silent  -f -k -X POST "https://api.korplink.com/api/v1/provisioning/peers" -H "accept: text/plain" -H "authorization: Basic $api" -H "Content-Type: application/json" -d $json -o "/etc/wireguard/wg0.conf"
sudo wg-quick up wg0
sudo systemctl enable --now wg-quick@wg0
resolvectl flush-caches
