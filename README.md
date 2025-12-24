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


t     → target
box   → machine
ph    → stage
s     → new session
listen→ handler
sls   → sessions
scd   → interact


---------


t 192.168.222.202
box WEB18
s daemon apache_rce "cgi enabled"

listen
sls

ph foothold
ph privesc

note "try sudo -l + SUID hunt"

s daemon lpe
scd s01


```
