---
layout: docs
title: "Install Boxcar"
permalink: install/
---

Telnet or SSH to your unRAID machine, then run the installer.

<div class="alert alert-info">
	The installer will use about 45MB on your flash device. If you have less than 512MB RAM the installer may fail. Thin uses about 36MB to run the web process.
</div>

## Prerequisite

Installer requires curl. Skip this step if you already have curl installed.

```bash
# Curl installer
$ wget -qO- http://boxcar.nicinabox.com/install_curl | sh -
```

## Install

```bash
# Boxcar installer
$ bash <(curl -s http://boxcar.nicinabox.com/install)
```

## Dependencies

In order to compile some software (Ruby, etc), we need to bring unRAID up to a higher baseline. The following are Slackware packages installed when you run the Boxcar installer. Other distros have something similar under a package like `dev-tools` or `build-essential`. These packages will be installed in /boot/extra for reuse on reboot.

* ncurses (5.9)
* glibc (2.13)
* libmpc (0.8.2)
* libelf (0.8.13)
* mpfr (3.0.1)
* kernel-headers (2.6.37.6_smp)
* gcc (4.5.2)
* gcc-g++ (4.5.2)
* binutils (2.21.51.0.6)
* make (3.82)
* automake (1.11.1)
* openssl (1.0.1c)
* infozip (6.0)
* sqlite (3.7.5)
* libyaml (0.1.4)
* ruby (1.9.3_p448)
