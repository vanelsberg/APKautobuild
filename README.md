# Android Studio APK autobuild (Intel/AMD64)

Docker automatic builder for Android APK's. *Note that the Android Studio SDK is only supports Intel/AMD64 platform!*

With APKautobuild you can build .APK installer files directly from Git code on any system supporting Docker. No need to install Android Studio or SDK's. 

Docker is supported for multiple platforms (Intel/AMD64 only):

    * Windows 10/11 (Command or WSL2)
    * Apple Mac Pro
    * Ubuntu/Linux (intel)

System requirements:

    Memory available: 12GB or more
    Docker memory available: at least 8GB
    Internet connection is required for pulling remote Docker image
 
# Quickstart for Windows 10/11

    1) Install ["Docker Desktop for Windows - x86_64"](https://docs.docker.com/desktop/setup/install/windows-install/) and Git

    2) Open the Windows command prompt

    3) Type:
       C: <enter>
       cd /
       mkdir android
       cd android
       git clone https://github.com/vanelsberg/APKautobuild.git
       cd APKautobuild

    4) Type:
       cd \android\APKautobuilder\data\keystore

        - Copy your keystore file (extension .jks) to this location
        - Create a plaintext password file named _ks-password_ containing 2 lines (see ks-password.sample):
          * line1: keystore password
          * line2: key password

    5) Type:
       cd \android\APKautobuilder
       notepad data\asbuilder.config
       - Check/edit the KEY_FILE (keystore file) and KEY_ALIAS (alias) names

       Note on GRADLE_OPTS:
       Set the number of workers to '1' (-Dorg.gradle.workers.max=1)
       Once this is working you can try setting up to 8 workers to improve build performance:

    6) Now try building the .APK's by typing:
       cd \android\APKautobuilder
       win_build_APK.cmd<enter>

       On a succesfull build you will find the .apk's at the location APKbuilder\data\output

# Quickstart Docker/WSL2

To build an Android APK using Docker you need to (see configuration):

    1) Install Docker Desktop
    2) Clone this project:
        mkdir /android
        cd android
        git clone https://github.com/vanelsberg/APKautobuild.git
        cd APKautobuild
    3) Setup your keystore at ./data/**keystore**
    4) Edit the configuration file ./data/**asbuilder.config** (or use the defaults)
    5) Build the .APK by running **./build_APK.sh --clean** (Windows: win_build_APK.cmd)
    6) Publish the build output by running **./publish.sh** (Windows: win_build_APK.cmd)

Optionally you can use alternate build configurations using multiple "data" directory locations:

By default the directory **"./data"** is used.
Optionally you can changed this to **"./data-'BUILDENV'"** by defining the **BUILDENV** setting in the config.build file.

## Note for building using the Windows command prompt (buuild_APK.cmd)

Functionality will be limited:

    * AAPS Fullrelease only
    * Configuration through ./data only (not configurable through BUILDENV)
    * Using **cleanbuild.cmd** to start a clean build

# Documentation

## For Windows, install WSL2 (Ubuntu 20.04 or higher)

Even thou you can build from teh Windows command prompt WSL is the the prefered build environment. 
The Windows Subsystem for Linux lets developers run a GNU/Linux environment.

    -- including most command-line tools, utilities, and applications
    -- directly on Windows, unmodified, without the overhead of a traditional virtual machine or dual-boot setup.

    https://docs.microsoft.com/en-us/windows/wsl/install

## Install Docker Desktop for Windows/WSL2 or Apple Mac Pro

Docker Desktop for Windows is the Community version of Docker for Microsoft Windows. You can download Docker Desktop for Windows from Docker Hub.

    https://docs.docker.com/docker-for-windows/install/
    or
    https://www.docker.com/products/docker-desktop

## Get the code
Open a terminal session on your Windows (command prompt), Windows/WSL2 or Mac Pro.
Next, create a base directory and clone the code form Github:

	mkdir /android
	cd /android
	git clone https://github.com/vanelsberg/APKautobuild.git .
	cd APKautobuild

## Configuration
To build the .APK file you need to:

    * Setup your keystore at data/**keystore**
    * Edit the configuration file data/**asbuilder.config** (optional, or use defaults)

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

* data/**asbuilder.config**

    This file contains the following configuration items. You may need to update them for your specific build.

    * Git config variables:

            GIT_PROJECT         Projectname
            GIT_REPO            Git repo clone url
            GIT_BRANCH          Git branch to build (e.g: "dev","master" - empty="master")
            GIT_COMMIT          Git commit hash to build (empty=latest commit)
            GIT_MERGE_PRNUM     Git PR number to merge with current branch/commit (e.g: "3347,3357,3362" or empty)

    * Signing keyfile, alias and password files:

            KEY_FILE
            KEY_ALIAS
            KEY_PASSW_FILE

    * Build variant:
            BUILD_VARIANT="FullRelease" or "aapsclientRelease" or "pumpcontrolRelease"

* Other configuration:

    * The script file _build_APK.sh_ defines a variable named **data_local** using confiuration as defined in the file _config.build_
    It defaults to the directory **data** in the root directory of this project but you may change this to any (sub)directory location
    on your local machine. For details see config.build.

## Building Android .APK files

Once your configuration is setup you can build your APK.

On initial run docker will need to download a docker image to the local docker image repository. The image is sized at about 1GB so, depending on your internet connection, this may take some time. Once the image is loaded succesive runs will start without downloading.

## Linux/WSL

To build on Linux (using defaults from _config.build_) run the following commands:

    chmod u+x build_APK.sh     # Make the script executable

    ./build_APK.sh --clean     # Run the script to build from scratch
    ./build_APK.sh --rebuild   # Run the script to build with new/updated code from Git
    ./build_APK.sh             # Run the script to rebuild using previous build result
    ./publish.sh               # Copy the output .apk to the 'builds' location

**You will find the build output in the location __data__/output**
**You will find the published output in the location __data__/builds**

## Windows 10/11

To build on Windows run the command batch file:

    build_APK.cmd

***Important**:

When editing the _aapsbuilder.config configuration file make sure not to change the file line ending from Unix 'LF' to Windows 'CR/LF'.
You can check by opening the file with Windows notepad.exe (enable the status bar from view) at look at the bottum-right of the window: it should say "Unix (LF), UTF-8"

Note that building directly from Windows (not WSL) only has basic build functionality. Building from WSL/Linux is preferred.

**You will find the build output in the location __data__/builds**

## Additional notes:
On first run Docker needs to download the APKbuilder image from the Docker repository. Depending on the speed of your internet connection
this may take some time. Subsequent builds however will reused the image downloaded locally.

An active internet connection is required while building the APK for getting the latest code and libraries to build the APK's

# Changes

20250410
    * Updated this README
    * Moved to Android SDK Platform and tools 35.0.2
    * Improved image size
    * Windows: allways do a clean build
    * Windows: add script for generating .jks keyfile

20240521
    * Updated this README
    * Updated the Docker builder image version
    * Added asbuilder.config support for optional PR merging

20250901
    * Updated the Docker builder image version
    * Fixed Git log needing user interaction on paging
    * Added asbuilder.config support for option build variants
