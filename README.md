# Homekit.sh plugin for Ouman.io API

Ouman.io provides a websocket API but there's no documentation for it (or at least I couldn't find any). Luckily Javascripts are practically never obfuscated. The data _could_ be read by subscribing to listen for changes, but I couldn't figure out how to get actual timestamps for the data so I decided to use the `trends` endpoint to read a bunch of values periodically. Using a REST API would be much easier, but I guess websockets are the current hype for everything.

Prerequisites
-------------
- get a computer (e.g. a server or a Raspberry Pi)
- install [Nix](https://nixos.org/download/)
- install [Homekit.sh](https://github.com/jyrimatti/homekit.sh)

Setup for home automation
-------------------------

```
cd ~/.config/homekit.sh/accessories
```

Clone this repo
```
git clone https://github.com/jyrimatti/ouman.git
cd ouman
```

Store Ouman.io credentials
```
echo '<my ouman user>' > .ouman-user
echo '<my ouman password>' > .ouman-pass
chmod go-rwx .ouman*
```

Setup for data collection
-------------------------

```
cd ~/.config/homekit.sh/accessories/ouman
```

Create the database
```
./ouman_createdb.sh
```

Running nix-shell periodically will bork your server by creating lots of files under /tmp, so you need to install dependencies globally by executing:
```
ls *collect2db.sh | tr ' ' '\n' | while read -r f; do { grep '^#!\s*nix-shell' $f; }; done | sed 's/.*-p//' | tr ' ' '\n' | sort | uniq | grep -v '^$' | sed 's/^/nixpkgs\./' | tr '\n' ' ' | { echo -n 'NIXPKGS_ALLOW_UNFREE=1 nix-env -I channel:nixos-23.11-small -iA '; cat; }
```

and modify path in crontab:
```
PATH=/home/pi/.local/nix-override:/home/pi/.nix-profile/bin:/usr/bin:/bin
```

Use cron job to read values periodically, for example:
```
* * * * * cd ~/.config/homekit.sh/accessories/ouman; ./ouman_collect2db.sh 2>&1 1>/dev/null | logger -p cron.info -t ouman
```

External hosting
----------------
If you want to replicate your collected database to another host, you can use a cron job:

```
0,15,30,45 * * * * cd ~/.config/homekit.sh/accessories/ouman; ./ouman_rsync.sh <remoteuser> <remotehost> <remotepath> 2>&1 1>/dev/null | logger -p cron.info -t oumanrsync
```

Make sure to configure your SSH to use public-key authentication for the remote host.
