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


box <BOX_NAME>
box WEB18


s <user> <vector> ["note text"]
s daemon apache_rce
s daemon apache_rce "cgi enabled"
s root sudo_lpe

listen [port]
listen
listen 443


<List sessions>
sls

ph foothold | privesc | proof
ph foothold
ph privesc

note "try sudo -l + SUID hunt"

scd <sXX>
scd s01


note "<text>"


```
