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

http://addons.boxcarapp.io/ ...or something

`boxcar.json` - define a plugin for Boxcar

    {
      "name": "Transmission", // required
      "version": "1.0.0",     // required
      "description": "Transmission daemon and settings",
      "install": "path/to/install.sh",
      "dependencies": {
        "gcc": "4.5.2",
        "git": ">= 1.7.4.4"
      }
    }

### Register addon

    boxcar addons:register NAME ENDPOINT

* Endpoint should be a git repo
* Cloned, packed (for easy reinstall after reboot), and installed. Source removed.

Since packages could contain malicious code, there should be a way for packages to be officially verified. Ideally all addons would be verified, but this is probably not possible.

Possibly search for potentially suspicious code like exec()?

### Example install:

    $ boxcar addons:add transmission
    Downloading               (git clone transmission.git /boot/config/plugins/transmission)
    Installing dependencies   (Parse boxcar.json, loop through dependencies.)
    Packing                   (makepkg transmission)
    Installing                (installpkg transmission)
                              (Run transmission install.sh)
                              (Remove /boot/config/plugins/transmission directory)
                              (Restart services?)
    Done!
