---
layout: docs
title: Install Slackware Packages
permalink: packages/
---

Boxcar makes it easy to install slackware packages by name.

```bash
boxcar packages:install name [version] [--persist]
```
If a version is not specified, the lastest available version will be used. If if `--persist` flag is used the package will be saved to `/boot/extra` so it can be installed on reboot.

## Example B: Installing latest openssl

```bash
boxcar packages:install openssl
```

## Example A: Installing openssl 1.0.1c and keep for reboot

```bash
boxcar packages:install openssl 1.0.1c --persist
```
