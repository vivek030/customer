#!/bin/bash
sudo apt-get update
sudo apt-get install wireguard-tools
email="demokorplink@alamanceinc.com"
read -p 'Enter Friendly Name: ' id
read -p 'Enter API Key: ' api
json='{"Email":"'"${email}"'","Identifier":"'"${id}"'"}'
curl --silent  -f -k -X POST "https://api.korplink.com/api/v1/provisioning/peers" -H "accept: text/plain" -H "authorization: Basic $api" -H "Content-Type: application/json" -d $json -o "/etc/wireguard/wg0.conf"
sudo systemctl start wg-quick@wg0
sudo systemctl enable wg-quick@wg0
resolvectl flush-caches