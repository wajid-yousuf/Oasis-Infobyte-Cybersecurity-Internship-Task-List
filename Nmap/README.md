Basic Networking scan with Nmap

First we start by setting up our lab environment, I will be using two VMs Ubuntu Server which is a non-GUI Operating System and the other VM will have Kali Linux installed.
The installation of these VMs is pretty straight-forward, various resources can be used if there are any problems.
Network Settings:
This is the most important step in this lab. We have to configure the network settings of these VMs. 
On VirtualBox, select Kali then click on Settings>Network, then check the "Enable Network Adapter" option, we can select NAT Network and set a name for our network e.g, "Test" or select Bridged Adapter so that our machines will be assigned an IP. Repeat this process for other VM also.

<img width="390" height="428" alt="one" src="https://github.com/user-attachments/assets/af6ca722-7b4e-4450-8045-c70aa6d836af" />

Since I'm using Kali, I don't need to install Nmap as Nmap along with other security tools comes preinstalled with Kali Linux. Still Nmap can be installed using the command 'sudo apt install nmap'.
Once everything is setup properly, we will first run 'ifconfig' command on our victim VM to know the IP address of that VM.
Then on our Kali VM we will run the command 'sudo nmap -sC -sV -p 1-1000 -T4 -oN ~/Desktop/nmap_scan_results.txt VM_IP'.

Explanation of this command:\
sudo: used for elevated privileges.\
nmap: network scanner/mapper.\
-sC: Runs default scripts from Nmap Scripting Engine(NSE). Good for basic scans.\
-sV: Service and service version detection.\
-p 1-1000: Scan ports between 1 and 1000.\
-T4: Timing template set to Aggressive. Speeds up the scan.\
-oN: save output in human readable format.\
<img width="798" height="288" alt="two" src="https://github.com/user-attachments/assets/7204186c-1b88-4bca-8dbf-40e56e7164f1" />\
Ubuntu VM has only two open ports(21,22) ftp and ssh namely. In a real-world scenario there may be tons of open ports on a machine at one time, most of which are useless ports. The most important or popular ports are (25,53,80,443) SMTP,DNS,HTTP,HTTPS.\
Nmap scan results can be stored in a file in other formats as well such as XML which is goog for parsers, using 'oX' option.\

<img width="849" height="352" alt="four" src="https://github.com/user-attachments/assets/2725e9ef-a2e7-4037-bbfa-0fbb7215ab5c" />
