## ddclient

### namecheap

```{file=/etc/ddclient.conf}
daemon=600                              # check every 300 seconds
syslog=yes                              # log update msgs to syslog
mail-failure=root                       # mail failed update msgs to root
pid=/run/ddclient/ddclient.pid          # record PID in file.
ssl=yes                                 # use ssl-support.  Works with

##
## NameCheap (namecheap.com)
##
usev6=ifv6
ifv6=eno1
use=web,web=dynamicdns.park-your-domain.com/getip
protocol=namecheap,                       \
server=dynamicdns.park-your-domain.com,   \
login=raxen001.xyz,                      \
password=<password> \
*
```

### cloudflare

```config {file=/etc/ddclient.conf}
daemon=600                              # check every 600 seconds
syslog=yes                              # log update msgs to syslog
mail-failure=root               	# mail failed update msgs to root
pid=/run/ddclient/ddclient.pid          # record PID in file.
ssl=yes                                 # use ssl-support.

usev6=ifv6
# ifv6=eno1
ifv6=wlp4s0
use=web,web=dynamicdns.park-your-domain.com/getip

##
## cloudflare (cloudflare.com)
##
protocol=cloudflare, \
zone=raxen001.xyz, \
ttl=1, \
login=token,	\
password=<API TOKEN> \
*.raxen001.xyz
```

### systemd

The systemd service file should have the user and group ddclient
the `/etc/ddclient/ddclient` should be owned by ddclient.
the `/run/pid/ddclient/ddclient.pid` should be owned by root.

```systemd {file=/usr/lib/systemd/system/ddclient.service}
[Unit]
Description=Dynamic DNS Update Client
After=syslog.target network-online.target nss-lookup.target

[Service]
User=ddclient
Group=ddclient
Type=exec
EnvironmentFile=-/etc/sysconfig/ddclient
ExecStartPre=/bin/touch /var/cache/ddclient/ddclient.cache
ExecStart=/usr/sbin/ddclient $DDCLIENT_OPTIONS --foreground

[Install]
WantedBy=multi-user.target
```
