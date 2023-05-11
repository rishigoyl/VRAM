# VRAM (Vulnerability Reconnaissance & Monit)
V-RAM (Vulnerability Reconnaissance and Monitoring), is a comprehensive attack surface management system. To simulate a network environment, we set up a local area network consisting of several virtual machines, including Kali, CentOS, Debian, and Windows, with Kali being the main machine and the others acting as host machines.

To identify active hosts on the network, we used the ping command and obtained their OS details, using nmap. We then requested user input to specify the target host for vulnerability scanning. Using Nmap, we performed a scan to discover any vulnerabilities and open ports. We utilized a predefined NSE script to detect vulnerabilities and saved the scan results in an XML file.

To make the results more accessible, we converted the XML file to an HTML format using the xsltproc tool and hosted the page locally on the network. To receive notification about the report generation, we implemented the notify tool, which sends a message to Telegram.

In addition, we also implemented Snort on the main machine. If someone attempts to access the machine via SSH and perform any unauthorized activities, we receive a notification on Telegram. Overall, our system provides an efficient and effective way to monitor and manage vulnerabilities on a network.
