# Boxcar

A modern management tool. Built with Sinatra, designed for new and experienced users alike.

## Install

    bash <(curl -s http://nicinabox.com/boxcar/install)

## Web

* Responsive
* Clean API
* Modern design
* Uses modern technologies

## CLI

    $ boxcar

The CLI uses the same API that the web interface uses.

## Addons

* Available through Addons tab in web app
* Or though CLI

        $ boxcar addon:list
        $ boxcar addon:add ADDON

## Developers

### Porting addons

* PLG conversion tool
* DSL for settings

### Registering an addon

Addons are registered with the Boxcar Registery. This is simply a list of available addons. Addons are installed from the author's repository.

        $ boxcar addon:register NAME GIT-ENDPOINT

### boxcar.json

Every addon has a JSON-formatted manifest file named boxcar.json that provides important information.

    {
      "name": "My Addon",
      "version": "semver string",
      "dependencies": []
    }
