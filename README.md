# Boxcar

A modern, responsive admin interface for unRAID. Built with Sinatra and Bootstrap, it's designed with the user in mind, the way a web app should be.

![Disks](screenshot_disks.png?raw=true)

## Project goals

This is a rather ambitious project. Like others, I was impressed by the features that unRAID offers, but found the management utility to be lacking in the design department (all aspects of design, including code, architecture, organization, user experience, interface, et al).

Goals:

* An interface designed for the user with feedback from the community
* Works across multiple platforms and devices
* A clean, organized codebase
* Test driven where possible
* Lower the bar for the community to read, fork, and contribute changes back to the project

This is not a skin, theme, or "redesign" of the exising webGui.

## Unknowns

Much of this project relies on disecting existing unRAID projects such as the official webGui, SimpleFeatures, and unMENU. They have been an enormous help in understanding how unRAID bridges the web interface to the core system. Unfortunately, many parts of these are somewhat cryptic and difficult to understand.

Some of current unknowns:

* What happens on the system when forms (like settings) are submitted?
* How are .ini and config files updated?
* Is it possible to run Sinatra with lighttpd?

## Developing locally
1. Grab the code and `bundle` the gems.
2. Run `touch db/development.db`
3. Run `rake db:migrate`
4. Make sure you have [memcached](http://www.memcached.org/) installed.
5. Run `rake s` to start the development server.
