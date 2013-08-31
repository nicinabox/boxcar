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
wget -qO- http://boxcar.nicinabox.com/install_curl | sh -
```

## Install

```bash
# Boxcar installer
bash <(curl -s http://boxcar.nicinabox.com/install)
```
