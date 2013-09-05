---
layout: docs
title: Update Boxcar
permalink: update/
published: true
---

Updating is only available from the command line since the web process is stopped during update.

```bash
$ boxcar update [version]
```

This will grab the latest version archive from Github, pack it on your machine, install new dependencies (if any), and restart the Boxcar server process. Version is optional and may be either a tag or branch.

For the lastest unstable (not recommended):

```bash
$ boxcar update master
```
