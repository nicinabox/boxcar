#!/bin/bash

ln -s /usr/apps/boxcar/bin/boxcar /usr/local/bin/boxcar
ln -s /etc/gemrc /root/.gemrc

echo "source /etc/boxcar" >> ~/.bashrc

# TODO: This is a workaround for started event not being fired in unRAID
startup_script=/usr/local/emhttp/plugins/boxcar/event/started
if ! grep -Fxq "$startup_script" /boot/config/go; then
  echo "$startup_script" >> /boot/config/go
fi
