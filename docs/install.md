---
layout: docs
title: "Install Boxcar"
permalink: install/
excerpt: Telnet or SSH to your unRAID machine, then run the installer.
---


## Prerequisite

Installer requires curl. Skip this step if you already have curl installed.

```bash
# Curl installer
wget -qO- http://nicinabox.com/boxcar/install_curl | sh -
```

## Install

```bash
# Boxcar installer
bash <(curl -s http://nicinabox.com/boxcar/install)
```
