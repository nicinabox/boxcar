#!/bin/bash
#
# Install: bash <(curl -s http://localhost:8000/pack.sh)
#

HOST=10.0.39

cd && mkdir build
wget -q http://$HOST:8000/boxcar.zip
mv boxcar.zip build/
cd build && unzip boxcar.zip
makepkg -c y ../boxcar.txz && cd
