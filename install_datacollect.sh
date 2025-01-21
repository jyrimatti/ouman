#!/bin/sh

scriptdir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

service="$(basename "$scriptdir")"
servicename=datacollect-$service
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
ExecStart=/bin/sh -c '. /etc/profile.d/nix.sh; LD_LIBRARY_PATH="$(find /nix/store -maxdepth 1 -name '*nss-mdns*' -type d)/lib" PATH=$HOME/.local/nix-override:\$PATH $scriptdir/${service}_collect2db.sh'
CPUWeight=128

ProtectSystem=strict
ProtectHome=read-only
ProtectKernelTunables=true
RestrictRealtime=true
RestrictSUIDSGID=true

StandardOutput=journal
StandardError=journal
SyslogIdentifier=datacollect
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

echo "Done! Data collection for $service is now usable as a systemd service!"
echo "You can run it manually with 'systemctl --user start $servicename.service'"
echo "Follow logs with 'journalctl -f -t datacollect'"
