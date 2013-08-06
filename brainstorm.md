# Primary components

* Installer
* Low level system API
* CLI
* Web App

## Installer

curl -L http://nicinabox.github.io/boxcar/install | bash

* Grabs tgz
* Runs installpkg
* Symlinks bin/boxcar

## API

* Persistence is tricky. production.db should be served from /boot/boxcar/db.
* Forms that modify the system should be abstracted and reused by CLI

## CLI

Example usage

* boxcar update
* boxcar addons
* boxcar addons:add ADDON
* boxcar users
* boxcar users:add USER
* boxcar users:delete USER
* boxcar shares
* boxcar shares:add NAME
* boxcar system:uptime
* boxcar system:cpu
