---
layout: docs
title: "Update Boxcar"
permalink: update/
---

```bash
$ boxcar update
```

Updating is only available from the command line since the web process is stopped during update.

This will pull down an archive of the latest version from Github, pack it on your machine, install new dependencies (if any), and restart the Boxcar server process.
