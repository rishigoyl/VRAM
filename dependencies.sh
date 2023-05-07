#!/bin/bash
requirements() {
	apt update -y
	apt upgrade -y
	command -v figlet > /dev/null 2>&1 || apt install figlet -y	> /dev/null 2>&1
	command -v lolcat > /dev/null 2>&1 || apt install lolcat -y > /dev/null 2>&1
	cd /usr/games
	cp -a lolcat /bin
	command -v vim > /dev/null 2>&1 || apt install vim -y
	command -v apache2 > /dev/null 2>&1 || apt install apache2 -y
	systemctl restart apache2
	systemctl enable apache2 > /dev/null 2>&1
        command -v nmap > /dev/null 2>&1 || apt install nmap -y
	command -v xsltproc > /dev/null 2>&1 || apt install xsltproc -y
	apt install golang-go -y
	go install -v github.com/projectdiscovery/notify/cmd/notify@latest
	cd ~/go/bin
	cp -av notify /bin > /dev/null 2>&1
	cd 
	echo ""
	echo "+--------------------------------------------+" 
	echo "|              INSTALLING SNORT              |" | lolcat
	echo "+--------------------------------------------+" 
	echo ""
	cd /etc/apt && mv sources.list sources.list-bkp
	echo "deb http://security.debian.org/debian-security bullseye-security main" > sources.list
	echo "deb-src http://security.debian.org/debian-security bullseye-security main" >> sources.list
	echo "deb http://deb.debian.org/debian bullseye main contrib non-free" >> sources.list
	cd /var/lib/apt/lists
	rm -f * > /dev/null 2>&1
	apt update -y
	apt upgrade -y
	apt install snort -y
	rm -f * > /dev/null 2>&1
	cd /etc/apt
	rm -f sources.list
	mv sources.list-bkp sources.list
	apt update -y
	apt upgrade -y
	clear

}
requirements
