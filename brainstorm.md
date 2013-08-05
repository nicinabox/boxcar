# Primary components

* Installer
* Low level system API
* CLI
* Web App

## Installer

curl -L http://boxcar.nicinabox.com/install | bash

* Grabs tgz
* Runs installpkg
* Symlinks bin/boxcar

## API

* Persistence is tricky. production.db should be served from /boot/boxcar/db.
* Forms that modify the system should be abstracted and reused by CLI

## CLI

Example usage

* boxcar update
* boxcar install <plugin>
* boxcar users list
* boxcar users add <username>
* boxcar users delete <username>
* boxcar shares
* boxcar shares add <name>
* boxcar system uptime
* boxcar system cpu_temp
