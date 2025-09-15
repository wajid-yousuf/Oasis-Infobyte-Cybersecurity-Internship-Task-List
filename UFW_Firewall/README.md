Task 2: Basic UFW Firewall configuration.\
Objective: Setup a basic firewall using UFW(Uncomplicated Firewall) on a Linux system.\
Tools: UFW Firewall(Uncomplicated Firewall)

In this task we will setup UFW Firewall on our Ubuntu Server VM, UFW Firewall comes preinstalled on most Linux systems, and can be installed using 'sudo apt install ufw'.\
<img width="522" height="149" alt="one" src="https://github.com/user-attachments/assets/01b377bf-6937-40fd-84e0-abccc4a2928d" />\
We have to configure the firewall to allow SSH and deny HTTP connections. We also have to check the firewall status and ensure that the correct rules are in place.\
Step 1: Establish IPv6 support in UFW.\
Use the command 'sudo nano /etc/default/ufw' to edit the file and make sure to enable IPv6, change the value of IPv6 from no to yes.\
<img width="500" height="600" alt="two" src="https://github.com/user-attachments/assets/9c6930cc-22da-4130-ab68-884fc9ed3db2" />\
We need to configure UFW policy, by default ufw block all incoming/inbound connections and allows all outgoing/outbound connections.\
Run the command 'sudo ufw default deny incoming' & 'sudo ufw default allow outgoing'.\



