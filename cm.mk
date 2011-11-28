# Inherit device configuration
$(call inherit-product, device/samsung/maguro/device.mk)

# Release name
PRODUCT_RELEASE_NAME := GN

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Product name
PRODUCT_NAME := cm_maguro

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := maguro

#Set build fingerprint / ID / Prduct Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=yakju BUILD_ID=ITL41D BUILD_DISPLAY_ID=ITL41D BUILD_FINGERPRINT="google/yakju/maguro:4.0.1/ITL41D/223971:user/release-keys" PRVIATE_BUILD_DESC="yakju-user 4.0.1 ITL41D 223971 release-keys"
