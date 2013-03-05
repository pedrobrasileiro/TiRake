TiRake
======

Rake scripts to Titanium Mobile + Alloy

**Only tested Titanium SDK 3.0.0.GA with Alloy in Mac OS X**


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
ln -s TiRake\RakeFile
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

Themes is automagically loads. Ex. If you have 2 themes (theme1 and theme2), your **rake -T** return this
```bash
    rake android:deploy           # Deploy Android App to Dropbox
    rake android:device           # Execute in Android Device, if connected
    rake android:emulator         # Execute in Android Emulator
    rake clean                    # Clean Project
    rake ios:deploy               # Deploy iOS App to Testflight
    rake ios:simulator            # Execute in iOS Simulator
    rake theme1:android:emulator  # Execute in Android Emulator with theme1 Theme
    rake theme1:ios:simulator     # Execute in iOS Simulator with theme1 Theme
    rake theme2:android:emulator  # Execute in Android Emulator with theme2 Theme
    rake theme2:ios:simulator     # Execute in iOS Simulator with theme2 Theme
```
