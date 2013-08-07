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

install () {
  for package in "$@"
  do
    name=`basename $package`

    if [ ! -f $name ]; then
      echo "Install $name"
      wget -q $packages$package
      installpkg $name
    fi
  done
}

mkdir -p /boot/extra && cd /boot/extra

# We gotta have better dependency management than this.
packages='http://slackware.cs.utah.edu/pub/slackware'
base_deps=( '/slackware-13.37/slackware/l/ncurses-5.9-i486-1.txz'
            '/slackware-13.37/slackware/l/glibc-2.13-i486-4.txz'
            '/slackware-13.37/slackware/l/glibc-solibs-2.11.1-i486-3.txz'
            '/slackware-13.37/slackware/l/libelf-0.8.13-i486-2.txz'
            '/slackware-13.37/slackware/l/libmpc-0.8.2-i486-2.txz'
            '/slackware-13.37/slackware/l/mpfr-3.0.1-i486-1.txz'

            '/slackware-13.37/slackware/n/gnupg-1.4.11-i486-1.txz'
            '/slackware-13.37/slackware/n/gpgme-1.3.0-i486-1.txz'
            '/slackware-13.37/slackware/n/libassuan-2.0.1-i486-1.txz'

            '/slackware-13.37/slackware/d/gcc-4.5.2-i486-2.txz'
            '/slackware-13.37/slackware/d/gcc-g++-4.5.2-i486-2.txz'
            '/slackware-13.37/slackware/d/git-1.7.4.4-i486-1.txz'
            '/slackware-13.37/slackware/d/python-2.6.6-i486-1.txz'
            '/slackware-13.1/slackware/d/binutils-2.20.51.0.8-i486-1.txz'
            '/slackware-13.37/slackware/d/make-3.82-i486-2.txz'

            '/slackware-13.37/slackware/ap/sqlite-3.7.5-i486-1.txz'

            '/slackware-14.0/slackware/l/libyaml-0.1.4-i486-1.txz'
            '/slackware-14.0/slackware/d/ruby-1.9.3_p194-i486-2.txz')


echo "Fetching dependencies..."
install ${base_deps[@]}

echo "Installing Boxcar..."
gem update --system
gem install bundler

# echo "Importing existing configuration..."
# echo "Updating /boot/go to start Boxcar on boot..."
# echo "All done!"
