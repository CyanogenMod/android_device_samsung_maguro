# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file includes all definitions that apply only to maguro devices
#
# Anything that is generic to all tuna products should go in the tuna directory
#
# Everything in this directory will become public

LOCAL_PATH := device/huawei/viva
DEVCOMMON_PATH := device/huawei/omap4-common

DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(DEVCOMMON_PATH)/overlay/cm

# These are the hardware-specific features
PRODUCT_COPY_FILES := \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

$(call inherit-product, device/samsung/tuna/device.mk)
$(call inherit-product-if-exists, vendor/samsung/maguro/maguro-vendor.mk)

# Media / Audio
PRODUCT_COPY_FILES += \
    $(DEVCOMMON_PATH)/viva-common/configs/audio/viva_audio_config.conf:system/etc/huawei/audio/cm_viva_audio_config.conf

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)
