# Server domain

*.raxen001.xyz

# nvidia

Enable nvidia persistanced

[nvidia-doc](https://docs.nvidia.com/deploy/driver-persistence/index.html)

```bash
sudo systemctl enable --now nvidia-persistenced.service
```

# DNS

The DNS being used by default is MagicDNS.
Can switch it off by the following code.

```bash
sudo tailscale set --accept-dns=false
resolvectl query google.com
```


## beets

Add `lyrics` to the `plugins` key in the `beets.conf`

# [Removed]

## Access netdata

```bash
sudo ufw allow 19999 comment 'Add netdata to firewall rule'
```

# trakt.tv

The list is imported by radarr and sonarr every 12 hours and `to-watch` are
automatically monitored and downloaded
