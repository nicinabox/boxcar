# Primary components

* Installer
* Low level system API
* CLI
* Web App
* Addons

## Installer

curl -L http://nicinabox.github.io/boxcar/install.sh | bash

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
* boxcar addons:update ADDON
* boxcar users
* boxcar users:add USER
* boxcar users:delete USER
* boxcar shares
* boxcar shares:add NAME
* boxcar system:uptime
* boxcar system:cpu

## Addons

Current plugins are mostly written in PHP. A boxcar specific system should require only minimal changes to port. If a plugin has system calls, that should all stay in tact.

http://addons.boxcarapp.io/

boxcar.json - define a plugin for Boxcar

    {
      "name": "Transmission",
      "version": "1.0.0",
      "dependencies": {
        "gcc": "gcc-4.5.2-i486-2.txz",
        "git": "git-1.7.4.4-i486-1.txz"
      }
    }

boxcar addons:register GIT-ENDPOINT

Endpoint should be a downloadable txz. It will be installed immediately.

Since packages could contain malicious code, there should be a way for packages to be officially verified. Ideally all addons would be verified, but this is probably not possible.

Possibly search for potentially malicious code like exec()?
