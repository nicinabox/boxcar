---
published: true
layout: post
title: "Fixing unRAID's Root Certificates"
date: "2013-10-02"
author: nicinabox
---

Recently and issue came up that prevented Bundler from being installed, and subsequently caused the Boxcar installation to fail. That error looks something like this:

	Unable to download data from https://rubygems.org/ - SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed

## The fix (overview)

OpenSSL ships with a utility called `c_rehash` which you can invoke on a directory to have all certificates indexed with appropriately named symlinks. 

1. Install `openssl`
2. Install `ca-certificates`
3. Run the `c_rehash` utility

## The copy-and-paste fix

I recommend doing this with [trolley](https://github.com/nicinabox/trolley), as it makes package management really easy. If you're not using it, or don't want to, just download and install these packages manually from your favorite mirror.

	trolley install openssl # Not necessary if you have it installed
    trolley install ca-certificates
    c_rehash