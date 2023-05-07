#!/bin/bash
echo ""
echo "+--------------------------------------------+" 
echo "|          INSTALLING DEPENDENCIES           |" 
echo "+--------------------------------------------+" 
echo " "
./dependencies.sh
./notify.sh
#Starting Apache service 
systemctl restart apache2 > /dev/null 2>&1
systemctl enable apache2  > /dev/null 2>&1
echo "" > /var/www/html/index.html
echo ""
echo "V - RAM" | figlet | lolcat -a

#Scanning network for all the hosts

echo "+--------------------------------------------+" 
echo "|              SCANNING NETWORK              |" | lolcat
echo "+--------------------------------------------+"  
echo " "
echo -e "\nChecking for all the active hosts in the network\nThis may take some time\n"
network=$( ip a | grep 'eth0'| grep -i 'scope' | awk '{print $2}' | awk -F "." '{$4="";print $0}' | sed 's/ /./g')
for addr in {1..254}
do
ip=$network$addr
if ping -c1 -w1 $ip > /dev/null 2>&1; then
echo -e $ip >> alive_hosts.txt
fi
done
echo " "
echo "+--------------------------------------------+" 
echo "|                 ACTIVE HOST                |" | lolcat 
echo "+--------------------------------------------+" 
echo " "
echo -e "\nActive hosts in your network are: \n"
echo " "
cat alive_hosts.txt
echo " "
echo " "
echo "+--------------------------------------------+" 
echo "|            PERFORMING NMAP SCAN            |" | lolcat 
echo "+--------------------------------------------+" 
echo " "
#Performing NMAP Scan to determine the Operating System
echo "+--------------------------------------------+" 
echo "|         ACTIVE HOST WITH OS DETAILS        |" | lolcat 
echo "+--------------------------------------------+" 
echo " "
while read host;do
	nmap -O $host | grep "OS details: " > host_OS.txt 
	echo $host "|" $(cat host_OS.txt | grep "OS details" | awk -F ":" '{print $2}')
done < alive_hosts.txt
#Enter the host for Vulnerability Detection
echo " "
echo -e "\nEnter the host address for Vulnerability Check eg: xxx.xxx.xxx.xxx\n"
read -p "Enter the host IP: " hostip
echo "+--------------------------------------------+" 
echo "|        SCANNING HOST FOR VULNERABILITY     |" | lolcat 
echo "+--------------------------------------------+"
echo ""
nmap -sV --script=vuln $hostip -oX index.xml > target.txt
echo " "
echo "+--------------------------------------------+" 
echo "|                 OPEN PORTS                 |" | lolcat
echo "+--------------------------------------------+" 
echo " "
#Printing open ports from the scanned host
ip=$(cat target.txt | grep -e 'Nmap scan report for' | grep -o '[0-9].*')
echo -e "\nScanned the host - " "${ip}\n"
cat target.txt | grep -e "PORT.*VERSION"
cat target.txt | grep -e "open"
echo " "
echo "Genetarting Report in HTML format....." | lolcat -a
echo " "
#Generating output in html format
xsltproc index.xml -o index.html
cp -av index.html /var/www/html > /dev/null 2>&1
systemctl restart apache2

echo "Vulnerability Scan Complete and the Report is generated" | notify --silent


