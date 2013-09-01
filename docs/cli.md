---
layout: docs
title: Basic CLI Usage
permalink: cli/
published: true
---

Telnet or SSH into your machine to run the boxcar command. You should see something similar to the following:

```bash
$ boxcar
Usage: boxcar COMMAND [command-specific-options]

Primary help topics, type "boxcar help TOPIC" for more details:

  addons  #  Manage unRAID Addons
  system  #  Display system information

Additional topics:

  help     #  List commands and display help
  server   #  Manage Boxcar server
  update   #  Manage updates for Boxcar
  version  #  Display version
```

## Start, stop, restart Boxcar

```bash
$ boxcar server:start
$ boxcar server:stop
$ boxcar server:restart
```
Note: Stop and start are called automatically during update