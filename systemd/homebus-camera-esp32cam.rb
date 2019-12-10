[Unit]
Description=Homebus ESP32Cam publisher
After=network.target

[Service]
Type=simple

User=homebus
WorkingDirectory=/home/homebus/homebus-camera-esp32cam

ExecStart=/home/homebus/.rbenv/bin/rbenv exec bundle exec homebus-camera-esp32cam.rb
TimeoutSec=30

Restart=always
RestartSec=90
StartLimitInterval=400
StartLimitBurst=3

[Install]
WantedBy=multi-user.target
