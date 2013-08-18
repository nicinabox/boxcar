#!/bin/bash
#
# Install: bash <(curl -s https://rawgithub.com/nicinabox/boxcar/master/install.sh)
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
      wget -q $host$package
      installpkg $name
    fi
  done
}

# mkdir -p /boot/extra && cd $_

# # We gotta have better dependency management than this.
# host='http://slackware.cs.utah.edu/pub/slackware'
# base_deps=( '/slackware-13.37/slackware/l/ncurses-5.9-i486-1.txz'
#             '/slackware-13.37/slackware/l/glibc-2.13-i486-4.txz'
#             '/slackware-13.37/slackware/l/glibc-solibs-2.11.1-i486-3.txz'
#             '/slackware-13.37/slackware/l/libelf-0.8.13-i486-2.txz'
#             '/slackware-13.37/slackware/l/libmpc-0.8.2-i486-2.txz'
#             '/slackware-13.37/slackware/l/mpfr-3.0.1-i486-1.txz'

#             '/slackware-13.37/slackware/n/gnupg-1.4.11-i486-1.txz'

#             '/slackware-13.37/slackware/n/gpgme-1.3.0-i486-1.txz'
#             '/slackware-13.37/slackware/n/libassuan-2.0.1-i486-1.txz'

#             '/slackware-13.37/slackware/d/kernel-headers-2.6.37.6_smp-x86-2.txz'
#             '/slackware-13.37/slackware/d/gcc-4.5.2-i486-2.txz'
#             '/slackware-13.37/slackware/d/gcc-g++-4.5.2-i486-2.txz'
#             '/slackware-13.37/slackware/d/git-1.7.4.4-i486-1.txz'
#             '/slackware-13.37/slackware/d/python-2.6.6-i486-1.txz'
#             '/slackware-13.37/slackware/d/binutils-2.21.51.0.6-i486-1.txz'
#             '/slackware-13.37/slackware/d/make-3.82-i486-2.txz'
#             '/slackware-13.37/slackware/d/automake-1.11.1-noarch-2.txz'

#             '/slackware-13.37/slackware/ap/sqlite-3.7.5-i486-1.txz'

#             '/slackware-14.0/slackware/l/libyaml-0.1.4-i486-1.txz'
#             '/slackware-14.0/slackware/d/ruby-1.9.3_p194-i486-2.txz'
#             '/slackware-14.0/patches/packages/ruby-1.9.3_p448-i486-1_slack14.0.txz')


# echo "Fetching dependencies..."
# install ${base_deps[@]}

echo "Installing Boxcar..."

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem update --system
gem install bundler
dest  = 'usr/apps'
mkdir -p build/$dest
git clone https://github.com/nicinabox/boxcar.git build/$dest
cd build
makepkg -c y ../boxcar.txz && cd && rm -rf build
installpkg boxcar.txz

# echo "Importing existing configuration..."

echo "Updating /boot/config/go to start Boxcar on boot..."

echo "/boot/config/boxcar" >> /boot/config/go
cat << 'EOF' > /boot/config/boxcar
echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
gem update --system
gem install bundler
EOF

echo "All done!"
