#!/bin/bash

ln -s /usr/apps/boxcar/bin/boxcar /usr/local/bin/boxcar
ln -s /etc/gemrc /root/.gemrc

echo "source /etc/boxcar" >> ~/.bashrc
