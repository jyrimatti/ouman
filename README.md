Some scripts to read data from air pumps using Ouman.io API (at least Swegon)

Ouman.io provides a websocket API but there's no documentation for it (or at least I couldn't find any). Luckily Javascripts are practically never obfuscated. The data _could_ be read by subscribing to listen for changes, but I couldn't figure out how to get actual timestamps for the data so I decided to use the `trends` endpoint to read a bunch of values periodically. Using a REST API would be much easier, but I guess websockets are the current hype for everything.

Feel free to use and modify these as you will. Please let me know of any improvements you make for yourself.

Functionality
=============
- collect data for long periods
- store data in SQLite database
- read individual values
- write individual commands
- directly usable with [homebridge](https://homebridge.io)

Prerequisites
=============
- get a computer (e.g. a virtual server or a Raspberry Pi)
- install Nix (or manually all the things used in scripts)
- install homebridge & plugins
  - `npm install -g --unsafe-perm homebridge`
  - `npm install -g --unsafe-perm homebridge-cmd4`

Setup
=====
Assuming user home directory
```
cd ~
```

Clone this repo
```
git clone https://github.com/jyrimatti/ouman.git
```

Store Ouman.io credentials
```
echo '<my ouman user>' > .ouman-user
echo '<my ouman password>' > .ouman-pass
chmod go-rwx .ouman*
```

Create database
```
./ouman_createdb.sh
```

[Setup cronjobs](#cron)

[Setup Homebridge](#homebridge-configuration)

~~profit!~~

Dependencies
============

Just install Nix, it handles all the dependencies for you.

However, constantly running nix-shell has a lot of overhead, so you might want to install all the required dependencies globally, and bypass nix-shell when executing scripts from within other processes (cron, cgi, homebridge...):

For example, installing with Nix:
```
> nix-env -f https://github.com/NixOS/nixpkgs/archive/nixos-23.05-small.tar.gz -iA nixpkgs.bash nixpkgs.sqlite nixpkgs.websocat nixpkgs.curl nixpkgs.jq
```

Then create somewhere a symlink named `nix-shell` pointing to just the regular shell:
```
> mkdir ~/.local/nix-override
> ln -s /home/pi/.nix-profile/bin/bash ~/.local/nix-override/nix-shell
```

after which you can override nix-shell with PATH:
```
PATH=~/.local/nix-override:$PATH ./homebridge/fireplace.sh
```

Cron
====
Use cron job to read values periodically, for example:
```
4,9,14,19,24,29,34,39,44,49,54,59 * * * * pi export PATH=~/.local/nix-override:$PATH; cd ~/ouman; ./ouman_collect2db.sh
```

This will periodically read specified datasets from Ouman.io and store them to the databases ignoring consecutive duplicate values.

Read and write
==============

Reading a value from Ouman.io (in this case `fireplaceFunction`):
```
./ouman_get.sh fireplaceFunctionActive
```

Writing a value to Ouman.io (in this case `fireplaceFunction`):
```
./ouman_post.sh fireplaceFunctionOn 1
```

You can see all available values/commands (that I know of) in `ouman_objects.sh`

See the ready made scripts in `./homebridge`

Homebridge configuration
========================

![HomeKit](homekit.jpeg)

You can use these scripts with Homebridge to show and modify values with Apple HomeKit.

See [example configuration](homebridge/config.json).

HTML page
=========

Build the javascripts by running
```
./installjs.sh
./package.sh
```

If you don't have Nix on some machine, just do it the old fashioned way.

Serve this directory with a web server. You can use `./serve.sh` to try locally. Use Nginx or other web server that supports byte-range-requests and caching for efficient SQLite database access over HTTP.

![Screenshot](screenshot.png)

External hosting
================
If you prefer to serve your graphs from another server, you can configure cronjobs to sync the databases to it. The scripts use vacuum to create an immutable snapshot to sync.

```
7,22,37,52 * * * * myuser export PATH=~/.local/nix-override:$PATH; cd ~/ouman; ./ouman_vacuum.sh && rsync -avzq -e "ssh -qo StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" ./ouman.db.bak me@myserver.net:/var/www/ouman/ouman.db

```

Standing on the shoulders of
============================
- [curl](https://curl.se)
- [websocat](https://github.com/vi/websocat)
- [getoptions](https://github.com/ko1nksm/getoptions)
- [jq](https://stedolan.github.io/jq/)
- [yq](https://github.com/kislyuk/yq)
- [htmlq](https://github.com/mgdm/htmlq)
- [SQLite](https://www.sqlite.org/index.html)
- [sql.js-httpvfs](https://github.com/phiresky/sql.js-httpvfs)
- [jquery](https://jquery.com)
- [flot](http://www.flotcharts.org)
- [homebridge](https://homebridge.io)
- [cmd4](https://github.com/ztalbot2000/homebridge-cmd4)