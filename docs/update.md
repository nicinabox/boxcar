---
layout: docs
title: "Update Boxcar"
permalink: update/
---

```bash
$ boxcar update OPTIONAL-VERSION
```

Updating is only available from the command line since the web process is stopped during update.

This will grab the latest version archive from Github, pack it on your machine, install new dependencies (if any), and restart the Boxcar server process.
