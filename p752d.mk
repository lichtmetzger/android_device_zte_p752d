$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/zte/p752d/p752d-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/zte/p752d/overlay

PRODUCT_AAPT_CONFIG := ldpi mdpi
PRODUCT_AAPT_PREF_CONFIG := ldpi

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio_policy.msm7x27a \
    audio.primary.msm7x27a

# Bluetooth
PRODUCT_PACKAGES += \
    btmac

# FM Radio
PRODUCT_PACKAGES += \
    libqcomfm_jni \
    qcom.fmradio
    
# Camera
PRODUCT_PACKAGES += \
    camera.msm7x27a

# GPS
PRODUCT_PACKAGES += \
    gps.tureis

# Graphics
PRODUCT_PACKAGES += \
    copybit.msm7x27a \
    gralloc.msm7x27a \
    hwcomposer.msm7x27a \
    libtilerenderer

# Lights
PRODUCT_PACKAGES += \
    lights.tureis

# Power HAL
PRODUCT_PACKAGES += \
    power.msm7x27a
    
# Sensors
PRODUCT_PACKAGES += \
    sensors.tureis

# Video
PRODUCT_PACKAGES += \
    libmm-omxcore \
    libOmxCore \
    libstagefrighthw
    
#ROM-specific applications
PRODUCT_PACKAGES += \
    Launcher2 \
    F-Droid \
    Music \
    TotalCommander \
    NakedBrowser

# Ramdisk
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/zte/p752d/ramdisk,root)

# Recovery
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/zte/p752d/prebuilt/recovery,recovery/root)

# Prebuilt
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/zte/p752d/prebuilt/system,system)

# Hardware features available on this device
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Enable repeatable keys in CWM
PRODUCT_PROPERTY_OVERRIDES += \
    ro.cwm.enable_key_repeat=true

$(call inherit-product, frameworks/native/build/phone-hdpi-dalvik-heap.mk)
$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_p752d
PRODUCT_DEVICE := p752d
PRODUCT_MANUFACTURER := ZTE
PRODUCT_MODEL := SmartChat
