Task 2: Basic UFW Firewall configuration.\
Objective: Setup a basic firewall using UFW(Uncomplicated Firewall) on a Linux system.\
Tools: UFW Firewall(Uncomplicated Firewall)\

In this task we will setup UFW Firewall on our Ubuntu Server VM, UFW Firewall comes preinstalled on most Linux systems, and can be installed using 'sudo apt install ufw'.\
<img width="522" height="149" alt="one" src="https://github.com/user-attachments/assets/01b377bf-6937-40fd-84e0-abccc4a2928d" />\
We have to configure the firewall to allow SSH and deny HTTP connections. We also have to check the firewall status and ensure that the correct rules are in place.\
Step 1: Establish IPv6 support in UFW.\
Use the command 'sudo nano /etc/default/ufw' to edit the file and make sure to enable IPv6, change the value of IPv6 from no to yes.\
<img width="500" height="600" alt="two" src="https://github.com/user-attachments/assets/9c6930cc-22da-4130-ab68-884fc9ed3db2" />\
We need to configure UFW policy, by default ufw blocks all incoming/inbound connections and allows all outgoing/outbound connections.\
Run the command 'sudo ufw default deny incoming' & 'sudo ufw default allow outgoing'.\
<img width="370" height="120" alt="three" src="https://github.com/user-attachments/assets/c422589c-5656-4548-8e41-7cff3a4c60fa" />\
These two commands reset's UFW's status to its factory settings.\
As stated in the task we have to configure the firewall to allow SSH traffic.\
Allow SSH traffic:\
We have to configure UFW to allow incoming/inbound SSH traffic.\
Using the command 'sudo ufw allow ssh' will configure ufw to accept ssh connections.\
<img width="272" height="72" alt="four" src="https://github.com/user-attachments/assets/3a0906fb-d3bf-4aa9-86f0-49368980e434" />\
This rule ensure that all inbound and outbound ssh traffic to be allowed.\
For the changes to take effect we first need to disable ufw then enable it by using these command respectively, 'sudo ufw disable' and 'sudo ufw enable'.\
<img width="399" height="80" alt="five" src="https://github.com/user-attachments/assets/974a0f79-5a21-4e67-9caf-67cd3fed8b15" />\
To verify if the firewall is working correctly we can run the following command:
'sudo ufw status verbose'.\
<img width="517" height="171" alt="six" src="https://github.com/user-attachments/assets/281e1541-3fad-4008-8fc7-381452f9a075" />\
Now to check if the ssh rule is working or not we can simply hop on other VM and try to login/ssh into Ubuntu VM using the command 'ssh username@VM_IP' if the rule was correctly implemented we will be able to login from Kali VM, if not there would be no output on the terminal.
<img width="749" height="542" alt="seven" src="https://github.com/user-attachments/assets/5eb62c0e-5665-4050-859f-08a8ec961b5a" />\
We are able to successfully login. So the UFW rule was implemented correctly.\
Now we have to implement UFW configuration to deny incoming http connections.\
We can simply type 'sudo ufw deny http' then check ufw status using the command 'sudo ufw status verbose'.

<img width="529" height="209" alt="ten" src="https://github.com/user-attachments/assets/b0cfac62-4276-41de-a2eb-be495be60a43" />\
We can try to 'curl http://VM_IP'. If blocked we will see connection timed out

