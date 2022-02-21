#!/usr/bin/bash
if [[ -d "/etc/v2ray" ]]; then
noc=`grep -c -E "^### " "/etc/v2ray/vmess-tls.json"`
if [[ ${noc} == '0' ]]; then
	echo -e "You have no existing clients!${n}"
	exit
fi
clear
echo "Select the existing client you want to remove!"
echo "=============================================="
grep -E "^### " "/etc/v2ray/vmess-tls.json" | cut -d ' ' -f 2-3 | nl -s ') '
echo "=============================================="
until [[ ${cn} -ge 1 && ${cn} -le ${noc} ]]; do
	if [[ ${cn} == '1' ]]; then
		read -p "Select client [1]: " cn
	else
		read -p "Select client [1-${noc}]: " cn
	fi
done
user=$(grep -E "^### " "/etc/v2ray/vmess-tls.json" | cut -d ' ' -f 2 | sed -n "${cn}"p)
exp=$(grep -E "^### " "/etc/v2ray/vmess-tls.json" | cut -d ' ' -f 3 | sed -n "${cn}"p)
sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/v2ray/vmess-tls.json
sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/v2ray/vmess-http.json
rm -f /etc/v2ray/${user}-tls.json
rm -f /etc/v2ray/${user}-http.json

sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/v2ray/vless-tls.json
sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/v2ray/vless-http.json

sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/v2ray/trojan.json

clear
echo -e "Successfully delete Account"
echo -e "==========================="
echo -e "Username : ${user}"
echo -e "Expired  : ${exp}"
echo -e "==========================="
systemctl restart v2ray@vmess-tls
systemctl restart v2ray@vmess-http
systemctl restart v2ray@vless-tls
systemctl restart v2ray@vless-http
systemctl restart v2ray@trojan

else
noc=`grep -c -E "^### " "/etc/xray/vmess-tls.json"`
if [[ ${noc} == '0' ]]; then
	echo -e "You have no existing clients!${n}"
	exit
fi
clear
echo "Select the existing client you want to remove!"
echo "=============================================="
grep -E "^### " "/etc/xray/vmess-tls.json" | cut -d ' ' -f 2-3 | nl -s ') '
echo "=============================================="
until [[ ${cn} -ge 1 && ${cn} -le ${noc} ]]; do
	if [[ ${cn} == '1' ]]; then
		read -p "Select client [1]: " cn
	else
		read -p "Select client [1-${noc}]: " cn
	fi
done
user=$(grep -E "^### " "/etc/xray/vmess-tls.json" | cut -d ' ' -f 2 | sed -n "${cn}"p)
exp=$(grep -E "^### " "/etc/xray/vmess-tls.json" | cut -d ' ' -f 3 | sed -n "${cn}"p)
sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/xray/vmess-tls.json
sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/xray/vmess-http.json
rm -f /etc/xray/${user}-tls.json
rm -f /etc/xray/${user}-http.json

sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/xray/vless-tls.json
sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/xray/vless-http.json

sed -i "/^### ${user} ${exp}/,/^},{/d" /etc/xray/trojan.json

clear
echo -e "Successfully delete Account"
echo -e "==========================="
echo -e "Username : ${user}"
echo -e "Expired  : ${exp}"
echo -e "==========================="
systemctl restart xray@vmess-tls
systemctl restart xray@vmess-http
systemctl restart xray@vless-tls
systemctl restart xray@vless-http
systemctl restart xray@trojan

fi