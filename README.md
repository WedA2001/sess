# sesskit

Quick OSCP session manager (MSF-style) without MSF.

## Install
```bash
git clone https://github.com/WedA2001/sess.git
cd sesskit
chmod +x setup.sh
./setup.sh
source ~/.zshrc


```



## Usage
```bash 
t 192.168.222.202
s daemon apache_rce "cgi enabled"

listen
sls

ph foothold
ph privesc

note "try sudo -l + SUID hunt"

s daemon lpe
scd s01
```
