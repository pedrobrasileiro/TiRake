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

Clone this project in your root project path
```bash
git clone git://github.com/pedrobrasileiro/TiRake.git
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

Create symbolic link in root project path
```bash
ln -s TiRake/RakeFile
```

Create config file after clone repo
```bash
cp TiRake/config.yml.default TiRake/config.yml
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

Environments
==============

Use env parameter, default is development
```bash
rake ios:simulator env=test
```

Choice your iOS Simulador Device ( >= SDK 3.1.0 )
===================================================

User parameter to launch your prefer device simulator or set parameter default_simulator in config.yml. Default is retina=true

Launch iOS Simulator - iPhone no Retina
```bash
rake ios:simulator retina=false
```

Launch iOS Simulator - iPhone Retina 3.5 inch
```bash
rake ios:simulator retina=true
```

Launch iOS Simulator - iPhone Retina 4 inch
```bash
rake ios:simulator iphone5=true
```

