**Objective:** Demonstrate an SQL Injection vulnerability on a web application (DVWA with low security).\
**Tools:** DVWA (Damn Vulnerable Web Application).

**Steps:** Install and configure DVWA on a local server or VM.\
Set the DVWA security to low.\
Perform and SQL Injection on the login page.\
Capture the output and explain the vulnerability.

DVWA is a purposely vulnerable web application that was designed for security professionals, students and developers to practice identifying and exploiting web vulnerabilities in a safe, controlled environment.\
Three security levels in DVWA: Low, Medium & High.

**DVWA Setup and Download:**\
On our Kali VM we first need to go to '/var/www/html', this is the web server folder for linux systems. All files that browser can access are stored in this folder.\
Use the command: 'cd /var/www/hmtl'. We can download DVWA with the following command:\
<img width="682" height="204" alt="one" src="https://github.com/user-attachments/assets/a23ab8d9-e4f6-4f97-8c67-ab5d3d8c691e" />\
We can go through DVWA's github page for setup and installation.\
**Setting File Permissions:**

We will use the command: 'sudo chmod -R 755 /var/www/html/dvwa' so that file owner has full control(read,write execute) permissions, while other are only able to read and execute.\
Configure DVWA:We need to change some settings in the configuration file so DVWA can connect to a database. Navigate to the following directory:'cd /var/www/htmldvwa/config'. We can check file contents.\
<img width="399" height="61" alt="two" src="https://github.com/user-attachments/assets/de41e2e4-adef-4828-a445-3e1ed2b47b14" />\
We will then rename this file to 'sudo mv config.inc.php.dist config.inc.php'.\
And we need to edit some contents of this file specifically security level is by default set to impossible we need to set it to 'low'.\
<img width="890" height="446" alt="three" src="https://github.com/user-attachments/assets/265fd642-47d5-40a8-a29b-48f40a9a878a" />\
Now we need to setup MySQL Database: DVWA needs a database to store its data we will use MySQL service.\
Simply run the command 'sudo service mysql start'.\
Now we need to login to MySQL as the root user so we can set up the DVWA database using the command 'sudo mysql -u root -p'. We will then be prompted to enter a password, enter 'p@ssw0rd' then press Enter.\
<img width="630" height="201" alt="four" src="https://github.com/user-attachments/assets/223c7f53-4f77-4774-8fd7-d3b3a3fa7745" />\
We will now create DVWA database: If the DVWA database doesn't already exist we can create it with this command: 'CREATE DATABASE dvwa;' (without quotes).\
We can now check the our database by using the command: 'show databases;'
<img width="490" height="282" alt="five" src="https://github.com/user-attachments/assets/e9cf6cc8-8677-4bc2-837f-542b64a58a53" />\
We can also list users in the system with this command:'SELECT User, Host FROM mysql.user;'\
<img width="448" height="156" alt="six" src="https://github.com/user-attachments/assets/f37362c2-7536-44b5-a285-6867dc9eebdb" />\
We need to create a new user for DVWA and give it access to the database, using the command: CREATE USER 'dvwa'@'127.0.0.1' IDENTIFIED BY 'p@ssw0rd'; and the second command is: GRANT ALL PRIVILEGES ON dvwa.* TO 'dvwa'@'127.0.0.1';\
<img width="658" height="124" alt="seven" src="https://github.com/user-attachments/assets/85061796-b1ce-4aee-8d2d-f5eac1956ddf" />\
Now we need to configure Apache and PHP by navigating to '/etc/php/8.2/apache2'.\
<img width="397" height="67" alt="eight" src="https://github.com/user-attachments/assets/25e82de9-2597-4106-94e2-8139d30e5202" />\
Now we need to edit php.ini file using the command 'sudo nano php.ini' and change the value of 'allow_url_include = Off' to 'On' which can be found in 'Fopen wrappers' section then save the file. Use CRTL+W and search for 'Fopen wrappers'.\
We will now restart the apache2 service for the changes to take place. using command : 'sudo service apache2 start'.\
Open the browser and type 'http://127.0.0.1/DVWA/setup.php'.\
<img width="878" height="564" alt="nine" src="https://github.com/user-attachments/assets/f0e83f9d-4588-4c0a-8376-22361bf43aeb" />\
Click on 'Create/Reset Database' at the bottom of the page. We will then be prompted to enter username & password creds on the following interface.\
<img width="523" height="368" alt="ten" src="https://github.com/user-attachments/assets/68b8e7d1-048f-44ed-a210-68bc4162ba7a" />\
Use Username:admin & Password:password\
Since we need to perform an SQLi we need to click on SQL Injection section on the left-side panel. Following interface will be shown.\
<img width="888" height="487" alt="eleven" src="https://github.com/user-attachments/assets/552e3059-a540-45fd-86fa-e3c652468b37" />\
At the bottom click on View Help, we can check objective and a little hint in spoilers.\
<img width="1149" height="533" alt="twelve" src="https://github.com/user-attachments/assets/24a7ae82-2bed-4d69-a344-c4f64a4f033f" />
We can use the very basic form of sqli 1'or'1'='1\
<img width="539" height="400" alt="thirteen" src="https://github.com/user-attachments/assets/b9b503a9-3fd9-4090-9c33-65c17bf6074b" />\
We are able to retrieve data about other users.

