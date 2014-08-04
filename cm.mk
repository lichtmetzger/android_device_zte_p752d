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
PRODUCT_MODEL := Smart Chat
PRODUCT_MANUFACTURER := ZTE
PRODUCT_RELEASE_NAME := Smart Chat

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
    BUILD_FINGERPRINT="ZTE/P752D/turies:4.3.1/GRK39F/20121206.095513.8829:user/release-keys" \
    PRIVATE_BUILD_DESC="P752D-user 4.3.1 GRK39F 20121206.095513.8829 release-keys"
