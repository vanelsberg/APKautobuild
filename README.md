# Android Studio APK autobuild

Docker automatic builder for Android APK's

With APKautobuild you can build .APK installer files on any system supporting Docker. No need to install Android Studio or SDK's. Docker is supported for multiple platforms:

    * Linux
    * Windows
    * Mac

# Preparations

To build an Android APK using Docker you need:

    * Install docker
    * Setup your keystore at data/**keystore**
    * Edit the configuration file data/**source.environment**

## Install WSL2/Ubuntu18.04 (Optional)

The Windows Subsystem for Linux lets developers run a GNU/Linux environment -- including most command-line tools, utilities, and applications -- directly on Windows, unmodified, without the overhead of a traditional virtual machine or dual-boot setup.

    https://docs.microsoft.com/en-us/windows/wsl/install-win10

## Install Docker Desktop for Windows/WSL

Docker Desktop for Windows is the Community version of Docker for Microsoft Windows. You can download Docker Desktop for Windows from Docker Hub.

    https://docs.docker.com/docker-for-windows/install/
    or
    https://www.docker.com/products/docker-desktop

## Configuration
To build from Linux you need to:

    * Setup your keystore at data/**keystore**
    * Edit the configuration file data/**asbuilder.config**

## Data directory:
On startup the docker countainer mounts a data directory for storing configuration data and build results:

    * data/keystore:
        Must contain theh folowing files:
            appkeyAndroidAPK-keystore.jks
            ks-password
    * data/output:
        Must contain the following files:
            appkeyAndroidAPK-keystore.jks   -> personal keystore
            ks-password                     -> password file

The documentation uses the above defaults for keystore and password filenames. Optionally change the default keystore and password files throug ediiting the configuration file. 

Configuration is in the file _aapsbuilder.config_:

## Signing Keystore:

* data/**keystore/ks-password**

    To sign .APK's after building you need to configuare the keystore- and key password for your keystore file:

    Create a plaintext password file named _ks-password_ containing 2 lines (see ks-password.sample):
    * line1: keystore password
    * line2: key password


* data/**keystore/appkeyAndroidAPK-keystore.jks**

    To sign your .APK installer files you need to copy your Android keystore file named _appkeyAndroidAPK-keystore.jks_ to the location /data/keystore. 

    _Remark:_

    You can use a keystore generated from [Android Studio](https://androidaps.readthedocs.io/en/latest/EN/Installing-AndroidAPS/Building-APK.html#generate-signed-apk)
    or generate a new keystore file using the Docker autobuilder. Make sure to define your password in the ks-password file, then run:

        ./generate-keystore.sh

    The above prompts you for "Distinguished Name" fields for your key. It then generates a new keystore file. The key generated is valid for 10,000 days.

    _Note that you can only update an APK with a new version that was signed with the same key. When generating a new keystore make sure you uninstall the APK first before installing the new version build bij autobuild!_

## Configuration:

* data/**source.environment**

    This file contains the following configuration items. You may need to update them for your specific build.

    * Git config variables:

            GIT_PROJECT
            GIT_REPO
            GIT_BRANCH
            GIT_COMMIT

    * Signing keyfile, alias and password files:

            KEY_FILE
            KEY_ALIAS
            KEY_PASSW_FILE

* Other configuration:

    * The script file _dbrun.sh_ defines a variable named **data_local**.
    It defaults to the directory **data** in the root directory of this project but you may change this to any directory location on your local machine.

## Building Android .APK files

Once your configuration is setup you can build your APK.

On initial run docker will need to download a docker image to the local docker image repository. The image is sized at about 1GB so, depending on your internet connection, this may take some time. Once the image is loaded succesive runs will start without downloading.

## Linux/WSL

To build on Linux run the following commands:

    chmod u+x build_AAPS.sh     # Make the script executable

    ./build_AAPS.sh             # Run the script


**You will find the build output in the location __data__/output**

## Windows 10

To build on Windows run the command batch file:

    build_AAPS.cmd

* **Important**:

    When editing the _aapsbuilder.config configuration file make sure not to change the file line ending from Unix 'LF' to Windows 'CR/LF'.
    You can check by openeing the file with Windows notepad.exe (enable the status bar from view) at look at the bottum-right of the window: it should say "Unix (LF), UTF-8"

**You will find the build output in the location __data__/output**

## MacOS

TODO: Untested!?
