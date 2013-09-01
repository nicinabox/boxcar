---
layout: docs
title: Update Boxcar
permalink: update/
published: true
---

Updating is only available from the command line since the web process is stopped during update.

```bash
$ boxcar update [VERSION]
```

This will grab the latest version archive from Github, pack it on your machine, install new dependencies (if any), and restart the Boxcar server process. [VERSION] is optional and is either a tag or branch. 

For the lastest unstable:

```bash
$ boxcar update master
```
