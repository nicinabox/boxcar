#!/bin/bash
#
# Install: bash <(curl -s http://localhost:8000/install.sh)
#

echo "Hi! You're about to install Boxcar for unRAID. We'll get you setup with a new web interface and command line tool. Then, we'll import settings from your existing unRAID configuration".

printf "Cool? [y/N] "
read install_boxcar

if [[ $install_boxcar != "y" ]]; then
  echo "Bummer, dude."
  exit
fi

fragile_install () {
  for i in "$@"
  do
    echo "Install $i"
    wget -q http://slackware.cs.utah.edu/pub/slackware/slackware-13.37/slackware/d/$i
    installpkg $i
  done
}

slapt_install () {
  for i in "$@"
  do
    echo "Install $i"
    slapt-get -i $i
  done
}

cd /boot/extra

slapt_get=( 'libassuan-2.0.1-i486-1.txz'
            'gpgme-1.3.0-i486-1.txz'
            'slapt-get-0.10.2p-i386-1.tgz')

echo "Installing slapt-get..."
fragile_install ${slapt_get[@]}

deps=('gcc-4.5.2-i486-2.txz'
      'git-1.7.4.4-i486-1.txz'
      'glibc-2.13-i486-4.txz'
      'glibc-solibs-2.11.1-i486-3.txz'
      'libelf-0.8.13-i486-2.txz'
      'libmpc-0.8.2-i486-2.txz'
      'mpfr-3.0.1-i486-1.txz'
      'yaml-0.1.4-i486-3sl.txz'
      'sqlite-3.7.5-i486-1.txz'
      'python-2.6.6-i486-1.txz'
      'ruby-1.9.3_p0-i486-1_vb.txz')

echo "Fetching dependencies..."
slapt_install ${deps[@]}

# echo "Installing Boxcar..."
# echo "Importing existing configuration..."
# echo "Updating /boot/go to start Boxcar on boot..."
# echo "All done!"
