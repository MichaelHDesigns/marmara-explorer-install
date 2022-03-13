#!/bin/bash
CUR_DIR=$(pwd)
cat <<EOF >$HOME/helpthehomelessd.service
[Unit]
Description=helpthehomeless coin daemon for MCL chain

[Service]
WorkingDirectory=$HOME/helpthehomelesscoin/src/
ExecStart=$HOME/helpthehomelesscoin/src/helpthehomelessd -ac_name=HTH -ac_supply=2000000 -ac_cc=2 -addnode=73.150.182.108 -addnode=155.138.198.71 -addnode=67.166.253.246 -txindex=1 -addressindex=1 -spentindex=1 -timestampindex=1 -ac_marmara=1 -ac_staked=75 -ac_reward=3000000000
ExecStop=$HOME/helpthehomelesscoin/src/helpthehomeless-cli -ac_name=HTH stop
User=$USER
Restart=on-failure
TimeoutSec=300

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF >$HOME/explorer-marmara.service
[Unit]
Description=marmara explorer service
Requires=helpthehomelessd.service
After=helpthehomelessd.service

[Service]
WorkingDirectory= $CUR_DIR/
ExecStart=$CUR_DIR/marmara-explorer-start.sh
User=$USER
Restart=on-failure
TimeoutSec=300

[Install]
WantedBy=multi-user.target
EOF
