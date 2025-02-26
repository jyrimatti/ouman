#!/bin/sh
set -eu

remoteuser=$1
remotehost=$2
remotefile=$3

scriptdir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

service="$(basename "$scriptdir")"
servicename=datasync-$service
servicedir=$HOME/.config/systemd/user

if [ ! -d "$servicedir" ]; then
    echo "Creating $servicedir..."
    mkdir -p "$servicedir"
fi

echo "Creating $servicedir/$servicename.service..."
cat > "$servicedir/$servicename.service" << EOF
[Unit]
Description=$servicename
After=syslog.target network.target

[Service]
Type=oneshot
ExecStart=/bin/sh -c '. /etc/profile.d/nix.sh; PATH=$HOME/.local/nix-override:\$PATH $scriptdir/${service}_rsync.sh $remoteuser $remotehost $remotefile'
CPUQuota=20%

PrivateTmp=true
ProtectSystem=strict
ProtectHome=read-only
ProtectKernelTunables=true
RestrictRealtime=true
RestrictSUIDSGID=true

StandardOutput=journal
StandardError=journal
SyslogIdentifier=datasync
SyslogLevel=warning
WorkingDirectory=$scriptdir

[Install]
WantedBy=default.target
RequiredBy=network.target
EOF

echo "Reloading systemd config..."
systemctl --user daemon-reload

echo "Enabling user process lingering for $USER..."
loginctl enable-linger "$USER"

echo "Done! Data sync for $service is now usable as a systemd service!"
echo "You can run it manually with 'systemctl --user start $servicename.service'"
echo "Follow logs with 'journalctl -f -t datasync'"
