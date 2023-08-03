# Android Studio APK autobuild (Intel/AMD64)

Docker automatic builder for Android APK's. *Note that the Android Studio SDK is only supports Intel/AMD64 platform!*

With APKautobuild you can build .APK installer files directly from Git code on any system supporting Docker. No need to install Android Studio or SDK's. 

Docker is supported for multiple platforms (Intel/AMD64 only):

    * Windows and/or Windows WSL2
    * Linux
    * Mac (untested)

    Internal memory available: at least 16GB
 
# Preparations

To build an Android APK using Docker you need to:

    * Install Docker
    * Setup your keystore at data/**keystore**
    * Edit the configuration file data/**source.environment**

## Install WSL2 (Ubuntu 18.04 or higher), Optional

The Windows Subsystem for Linux lets developers run a GNU/Linux environment.

    -- including most command-line tools, utilities, and applications
    -- directly on Windows, unmodified, without the overhead of a traditional virtual machine or dual-boot setup.

    https://docs.microsoft.com/en-us/windows/wsl/install

## Install Docker Desktop for Windows/WSL2

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

    chmod u+x build_APK.sh     # Make the script executable

    ./build_APK.sh --clean     # Run the script to build from scratch
    ./build_APK.sh             # Run the script to rebuild using previous build result

**You will find the build output in the location __data__/output**

## Windows 10/11

To build on Windows run the command batch file:

    build_APK.cmd

* **Important**:

    When editing the _aapsbuilder.config configuration file make sure not to change the file line ending from Unix 'LF' to Windows 'CR/LF'.
    You can check by openeing the file with Windows notepad.exe (enable the status bar from view) at look at the bottum-right of the window: it should say "Unix (LF), UTF-8"

**You will find the build output in the location __data__/output**

## MacOS

TODO: Untested!?
