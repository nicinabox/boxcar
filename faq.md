---
layout: docs
title: Frequently Asked Questions
permalink: faq/
published: true
---

\[overview\]

### How is this different than the default unRAID webGui, unMENU, or SimpleFeatures?

Boxcar offers features that go far beyond the scope of those projects. Addons, for instance, are a one-stop-shop. Slackware packages can be installed by name. You can use it on your phone. Best of all, it's open source, development is constant, and releases are frequent.

### Is this a port of Simple Features?

No. I was inspired to build Boxcar after using SimpleFeatures and realizing that webGui couldn't be fixed or patched over with some pretty colors. SimpleFeatures is a great tool, but it doesn't change the underlying problems. unRAID needed it's own dedicated interface app.

### That's a lot of dependencies! Won't my machine be bloated?

No. A large majority of required packages are C libs, development headers, and a compiler. Most Linux distros ship with this under a single package called `build-essential` or `development-tools`. Slackware doesn't offer any dependency management and unRAID doesn't ship with these core packages, so we need to pull them in manually.

### I'm afraid it will break my machine. Is it safe?

Probably. There has been a very high success rate of installs and so far there have been no reports of conflicts with other plugins. Boxcar doesn't modify unRAID's webGui. Instead, it runs completely standalone. You don't need unMENU or SimpleFeatures for it to work (in fact, it's probably better if you don't).

### How can I uninstall it?

```bash
$ boxcar uninstall
```

### Will existing plugins work with Boxcar?

Yes and no. Boxcar does not support .plg plugins, but the contents of those plugins should work just fine. They need to be converted to a txz and the settings screen updated, if necessary.

### Can I make a feature request?

Absolutely! Post it on [Github Issues](https://github.com/nicinabox/boxcar/issues?page=1&state=open).

### How can I get help?

Join us on IRC! #unraid on irc.freenode.net
