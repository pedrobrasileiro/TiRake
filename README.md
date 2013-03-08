TiRake
======

Rake scripts to Titanium Mobile + Alloy

**Only tested Titanium SDK 3.0.2.GA with Titanium CLI, Alloy (for themes) in Mac OS X**

Prerequisites
===============

- Titanium CLI
- curl
- ruby with rake :P


Installation
============

Clone this project in your project root path
```bash
git clone git@github.com:pedrobrasileiro/TiRake.git
```

    app
        assets
        controllers
    modules
    plugins
    Resources
        iphone
        android
        alloy
    **HERE**

Create symbolic link in project root path
```bash
ln -s TiRake/RakeFile
```

Create config file after clone repo
```bash
cp config.yml.default config.yml
```

After all, 
```bash
rake -T 
```
Voilá!!!


Themes
==========

Themes is automagically loads. Ex. If you have 2 themes (theme1 and theme2), your **rake -T** return
```bash
rake android:device            # Execute in Android Device, if connected
rake android:emulator          # Execute in Android Emulator
rake android:testflight        # Deploy Android App to Testflight
rake clean                     # Clean Project
rake ios:deploy                # Deploy iOS App to Device via iTunes
rake ios:simulator             # Execute in iOS Simulator
rake ios:testflight            # Deploy iOS App to Testflight
rake theme1:android:device     # Execute in Android Device, if connected, with theme1 Theme
rake theme1:android:emulator   # Execute in Android Emulator with theme1 Theme
rake theme1:android:testflight # Deploy Android App to Testflight with theme1 Theme
rake theme1:ios:deploy         # Deploy iOS App to Device via iTunes with theme1 Theme
rake theme1:ios:simulator      # Execute in iOS Simulator with theme1 Theme
rake theme1:ios:testflight     # Deploy iOS App to Testflight with theme1 Theme
rake theme2:android:device     # Execute in Android Device, if connected, with theme2 Theme
rake theme2:android:emulator   # Execute in Android Emulator with theme2 Theme
rake theme2:android:testflight # Deploy Android App to Testflight with theme2 Theme
rake theme2:ios:deploy         # Deploy iOS App to Device via iTunes with theme2 Theme
rake theme2:ios:simulator      # Execute in iOS Simulator with theme2 Theme
rake theme2:ios:testflight     # Deploy iOS App to Testflight with theme2 Theme
```

Testflight
============

Deploy your apps in Android and iOS with one command

```bash
rake ios:testflight
```
or
```bash
rake android:testflight
```

http://pedrobrasileiro.me