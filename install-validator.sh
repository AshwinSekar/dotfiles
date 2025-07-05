#!/bin/bash

echo 'net.core setup'
sudo bash -c "cat >/etc/sysctl.d/20-solana.conf <<EOF
# Increase UDP buffer size
net.core.rmem_default = 134217728
net.core.rmem_max = 134217728
net.core.wmem_default = 134217728
net.core.wmem_max = 134217728

# Increase memory mapped files limit
vm.max_map_count = 2000000
EOF" && \
sudo sysctl -p /etc/sysctl.d/20-solana.conf

echo 'nofiles setup'
sudo bash -c "cat >/etc/security/limits.d/90-solana-nofiles.conf <<EOF
# Increase process file descriptor count limit
* - nofile 2000000
EOF"

echo 'logrotate'
sudo bash -c "cat >/etc/logrotate.d/sol <<EOF
$HOME/solana-validator.log {
  rotate 3
  daily
  missingok
  postrotate
    systemctl kill -s USR1 sol.service
  endscript
}
EOF"

echo 'dependencies'
sudo apt-get update
sudo apt-get install -y git htop silversearcher-ag iotop \
  libssl-dev libudev-dev pkg-config zlib1g-dev llvm clang \
  cmake make libprotobuf-dev protobuf-compiler nvme-cli \
  libclang-dev

echo 'agave git setup'
git clone https://github.com/anza-xyz/agave.git ~/agave
git clone git@github.com:AshwinSekar/jito-agave-mods.git ~/jito-agave-mods

echo 'sosh'
git clone https://github.com/mvines/sosh ~/sosh

echo '[ -f $HOME/sosh/sosh.bashrc ] && source $HOME/sosh/sosh.bashrc' >> ~/.bashrc
echo '[ -f $HOME/sosh/sosh.bashrc ] && source $HOME/sosh/sosh.bashrc' >> ~/.zshrc
echo '[ -f $HOME/sosh/sosh.profile ] && source $HOME/sosh/sosh.profile' >> ~/.profile

cat > ~/sosh-config.sh <<EOF
# Start with upstream defaults
source ~/sosh/sosh-config-default.sh

# Local config overrides go here
EOF

sudo bash -c "cat >/etc/systemd/system/sol.service <<EOF
[Unit]
Description=Solana Validator
After=network.target
StartLimitIntervalSec=0
Wants=sol-hc.service

[Service]
Type=simple
Restart=always
RestartSec=1
User=$USER
LimitNOFILE=2000000
LogRateLimitIntervalSec=0
ExecStart=$HOME/sosh/bin/validator.sh

[Install]
WantedBy=multi-user.target
EOF" &&

sudo bash -c "cat >/etc/systemd/system/sol-hc.service <<EOF
[Unit]
Description=Solana Validator Healthcheck
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=$USER
ExecStart=$HOME/sosh/bin/hc-service.sh

[Install]
WantedBy=multi-user.target
EOF" && sudo systemctl daemon-reload
