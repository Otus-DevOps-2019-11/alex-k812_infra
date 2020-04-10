cat << EOF > /etc/systemd/system/puma.service
[Unit]
Description=PumaWebServer
After=network.target

[Service]
Type=simple
User=ak
Group=ak
ExecStart=/usr/local/bin/puma
WorkingDirectory=/home/ak/reddit
Restart=always

[Install]
WantedBy=multi-user.target
EOF
chmod 664 /etc/systemd/system/puma.service
systemctl enable puma.service