$(call inherit-product, device/samsung/maguro/device.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/gsm.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=yakju BUILD_ID=ITL41D BUILD_DISPLAY_ID=ITL41D BUILD_FINGERPRINT="google/yakju/maguro:4.0.1/ITL41D/223971:user/release-keys" PRVIATE_BUILD_DESC="yakju-user 4.0.1 ITL41D 223971 release-keys"

PRODUCT_NAME := cm_maguro
PRODUCT_DEVICE := maguro
PRODUCT_BRAND := google
PRODUCT_RELEASE_NAME := GN

