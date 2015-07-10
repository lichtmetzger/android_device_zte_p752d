CyanogenMod 10.2 device configuration for ZTE P752D/Vodafone Smart Chat 865.

http://www.modaco.com/topic/375407-cm102-431-schmatzlers-rom-for-the-zte-p752dvodafone-smartchat-865/

How to build:
-------------

Initialize repo:

    repo init -u git://github.com/CyanogenMod/android.git -b cm-10.2
    curl --create-dirs -L -o .repo/local_manifests/local_manifest.xml -O -L https://raw.github.com/legaCyMod/android_local_manifest/cm-10.2/local_manifest.xml
    curl -L -o .repo/local_manifests/manifest_zte_p752d.xml -O -L https://raw.github.com/schmatzler/android_device_zte_p752d/manifest_zte_p752d.xml
    repo sync

Compile:

    . build/envsetup.sh
    brunch p752d

