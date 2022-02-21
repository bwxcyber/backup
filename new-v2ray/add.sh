#!/usr/bin/bash
if [[ -d "/etc/v2ray" ]]; then
domain=`cat /etc/address/host`
until [[ ${user} =~ ^[a-zA-Z0-9_]+$ && ${exists} == '0' ]]; do
      read -p "Username : " user
      exists=$(grep -w ${user} /etc/v2ray/vmess-tls.json | wc -l)
      if [[ ${exists} == '1' ]]; then
            echo -e "${user} already exists, Please choose another name!"
            exit
      fi
done
uuid=`uuidgen`
read -p "Expired  : " e
exp=$(date -d "${e} days" +"%Y-%m-%d")
sed -i '/#client$/a\### '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"64"',"email": "'""${user}""'"' /etc/v2ray/vmess-tls.json
sed -i '/#client$/a\### '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"64"',"email": "'""${user}""'"' /etc/v2ray/vmess-http.json
cat > /etc/v2ray/${user}-tls.json <<-EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "64",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
cat > /etc/v2ray/${user}-http.json <<-EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "64",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF
vmtls="vmess://$(base64 -w 0 /etc/v2ray/${user}-tls.json)"
vmhttp="vmess://$(base64 -w 0 /etc/v2ray/${user}-http.json)"

exp=$(date -d "${e} days" +"%Y-%m-%d")
sed -i '/#client$/a\### '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","email": "'""${user}""'"' /etc/v2ray/vless-tls.json
sed -i '/#client$/a\### '"${user} $exp"'\
},{"id": "'""${uuid}""'","email": "'""${user}""'"' /etc/v2ray/vless-http.json
vltls="vless://${uuid}@${domain}:2443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlhttp="vless://${uuid}@${domain}:880?path=/vless&encryption=none&type=ws#${user}"

exp=$(date -d "${e} days" +"%Y-%m-%d")
sed -i '/#client$/a\### '"${user} ${exp}"'\
},{"password": "'""${uuid}""'","email": "'""${user}""'"' /etc/v2ray/trojan.json
link="trojan://${uuid}@${domain}:8443#${user}"

clear
echo -e "=====================-VMESS-====================="
echo -e "Remarks   : ${user}"
echo -e "Domain    : ${domain}"
echo -e "TLS Port  : 443"
echo -e "HTTP Port : 80"
echo -e "id        : ${uuid}"
echo -e "alterId   : 64"
echo -e "security  : auto"
echo -e "Network   : ws"
echo -e "path      : /vmess"
echo -e "================================================="
echo -e "Link TLS  : ${vmtls}"
echo -e "================================================="
echo -e "Link HTTP : ${vmhttp}"
echo -e "================================================="
echo -e "Expired   : ${exp}"
echo -e "================================================="
echo
echo -e "=====================-VLESS-====================="
echo -e "Remarks    : ${user}"
echo -e "Domain     : ${domain}"
echo -e "TLS Port   : 2443"
echo -e "HTTP Port  : 880"
echo -e "id         : ${uuid}"
echo -e "encryption : none"
echo -e "Network    : ws"
echo -e "path       : /vless"
echo -e "================================================="
echo -e "Link TLS   : ${vltls}"
echo -e "================================================="
echo -e "Link HTTP  : ${vlhttp}"
echo -e "================================================="
echo -e "Expired    : ${exp}"
echo -e "================================================="
echo
echo -e "====================-TROJAN-===================="
echo -e "Remarks  : ${user}"
echo -e "Domain   : ${domain}"
echo -e "Port     : 8443"
echo -e "Password : ${uuid}"
echo -e "================================================"
echo -e "Link     : ${link}"
echo -e "================================================"
echo -e "Expired  : ${exp}"
echo -e "================================================"
systemctl restart v2ray@vmess-tls
systemctl restart v2ray@vmess-http
systemctl restart v2ray@vless-tls
systemctl restart v2ray@vless-http
systemctl restart v2ray@trojan

else
domain=`cat /etc/address/host`
until [[ ${user} =~ ^[a-zA-Z0-9_]+$ && ${exists} == '0' ]]; do
      read -p "Username : " user
      exists=$(grep -w ${user} /etc/xray/vmess-tls.json | wc -l)
      if [[ ${exists} == '1' ]]; then
            echo -e "${user} already exists, Please choose another name!"
            exit
      fi
done
uuid=`uuidgen`
read -p "Expired  : " e
exp=$(date -d "${e} days" +"%Y-%m-%d")
sed -i '/#client$/a\### '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"64"',"email": "'""${user}""'"' /etc/xray/vmess-tls.json
sed -i '/#client$/a\### '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","alterId": '"64"',"email": "'""${user}""'"' /etc/xray/vmess-http.json
cat > /etc/xray/${user}-tls.json <<-EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "64",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF
cat > /etc/xray/${user}-http.json <<-EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "64",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF
vmtls="vmess://$(base64 -w 0 /etc/xray/${user}-tls.json)"
vmhttp="vmess://$(base64 -w 0 /etc/xray/${user}-http.json)"

exp=$(date -d "${e} days" +"%Y-%m-%d")
sed -i '/#client$/a\### '"${user} ${exp}"'\
},{"id": "'""${uuid}""'","email": "'""${user}""'"' /etc/xray/vless-tls.json
sed -i '/#client$/a\### '"${user} $exp"'\
},{"id": "'""${uuid}""'","email": "'""${user}""'"' /etc/xray/vless-http.json
vltls="vless://${uuid}@${domain}:2443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlhttp="vless://${uuid}@${domain}:880?path=/vless&encryption=none&type=ws#${user}"

exp=$(date -d "${e} days" +"%Y-%m-%d")
sed -i '/#client$/a\### '"${user} ${exp}"'\
},{"password": "'""${uuid}""'","email": "'""${user}""'"' /etc/xray/trojan.json
link="trojan://${uuid}@${domain}:8443#${user}"

clear
echo -e "=====================-VMESS-====================="
echo -e "Remarks   : ${user}"
echo -e "Domain    : ${domain}"
echo -e "TLS Port  : 443"
echo -e "HTTP Port : 80"
echo -e "id        : ${uuid}"
echo -e "alterId   : 64"
echo -e "security  : auto"
echo -e "Network   : ws"
echo -e "path      : /vmess"
echo -e "================================================="
echo -e "Link TLS  : ${vmtls}"
echo -e "================================================="
echo -e "Link HTTP : ${vmhttp}"
echo -e "================================================="
echo -e "Expired   : ${exp}"
echo -e "================================================="
echo
echo -e "=====================-VLESS-====================="
echo -e "Remarks    : ${user}"
echo -e "Domain     : ${domain}"
echo -e "TLS Port   : 2443"
echo -e "HTTP Port  : 880"
echo -e "id         : ${uuid}"
echo -e "encryption : none"
echo -e "Network    : ws"
echo -e "path       : /vless"
echo -e "================================================="
echo -e "Link TLS   : ${vltls}"
echo -e "================================================="
echo -e "Link HTTP  : ${vlhttp}"
echo -e "================================================="
echo -e "Expired    : ${exp}"
echo -e "================================================="
echo
echo -e "====================-TROJAN-===================="
echo -e "Remarks  : ${user}"
echo -e "Domain   : ${domain}"
echo -e "Port     : 8443"
echo -e "Password : ${uuid}"
echo -e "================================================"
echo -e "Link     : ${link}"
echo -e "================================================"
echo -e "Expired  : ${exp}"
echo -e "================================================"
systemctl restart xray@vmess-tls
systemctl restart xray@vmess-http
systemctl restart xray@vless-tls
systemctl restart xray@vless-http
systemctl restart xray@trojan

fi