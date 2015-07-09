# Boot animation
TARGET_SCREEN_HEIGHT := 240
TARGET_SCREEN_WIDTH := 320

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_mini_phone.mk)

# Inherit device configuration
$(call inherit-product, device/zte/p752d/p752d.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := p752d
PRODUCT_NAME := cm_p752d
PRODUCT_BRAND := ZTE
PRODUCT_MODEL := SmartChat
PRODUCT_MANUFACTURER := ZTE
PRODUCT_RELEASE_NAME := SmartChat
