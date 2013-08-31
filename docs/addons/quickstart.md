---
layout: docs
title: "Quick-start Guide"
permalink: quickstart/
---

Boxcar Addons use the native Slackware package system for installation and removal. This allows us to piggyback without any special system installers.

## What's a Slackware package then?

It's essentially a tarball that, when extracted by pkgtools, has its contents copied to their respective locations on the filesystem.

Let's say your package looks something like this:

```
boot/
  config/
    boxcar
install/
  doinst.sh
usr/
  apps/
    boxcar/
    .../
```

Those directories will be copied to the filesystem in `/boot` and `/usr`, respectively. `install` is used by `installpkg` and is not copied to the filesystem.

## Metadata

Boxcar requires a special file, `boxcar.json` in the root of your addon. This is metadata for name, version, description, dependencies, etc. The addon registry looks for this file when registering a package.

## Post-install

`installpkg` will automatically run `install/doinst.sh` in your package. Use this file for any post-install scripts you need to run (starting services, updating configs, etc).
