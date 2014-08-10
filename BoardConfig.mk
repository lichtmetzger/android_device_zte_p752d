#
# Copyright (C) 2011 The Android Open-Source Project
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
#
-include vendor/zte/p752d/BoardConfigVendor.mk

# Platform
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

TARGET_BOARD_PLATFORM := msm7x27a
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200

TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a5
TARGET_ARCH_VARIANT := armv7-a-neon

TARGET_NO_HW_VSYNC := true

ARCH_ARM_HAVE_TLS_REGISTER := true

TARGET_GLOBAL_CFLAGS += -mtune=cortex-a5 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a5 -mfpu=neon -mfloat-abi=softfp

# Kernel
TARGET_KERNEL_SOURCE := kernel/zte/p752d
TARGET_KERNEL_CONFIG := cyanogen_p752d_defconfig
TARGET_BOOTLOADER_BOARD_NAME := tureis
# For debugging via framebuffer, uncomment this. Remember to activate framebuffer in defconfig:
#BOARD_KERNEL_CMDLINE := androidboot.hardware=tureis console=tty0 no_console_suspend=1
BOARD_KERNEL_CMDLINE := androidboot.hardware=tureis console=null
BOARD_KERNEL_BASE := 0x200000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x01100000
USE_CCACHE := 1

# Use gcc 4.6.3 for kernel (default gcc does not boot)
# Had to modify /build/core/tasks/kernel.mk :
# ARM_CROSS_COMPILE:=CROSS_COMPILE="$(ccache) $(ANDROID_BUILD_TOP)/kernel/zte/p752d/$(TARGET_KERNEL_CUSTOM_TOOLCHAIN)/bin/arm-linux-androideabi-"
TARGET_KERNEL_CUSTOM_TOOLCHAIN := toolchain-4.6.3

TARGET_SPECIFIC_HEADER_PATH := device/zte/p752d/include

# Graphics
BOARD_EGL_CFG := device/zte/p752d/prebuilt/system/lib/egl/egl.cfg
USE_OPENGL_RENDERER := true
TARGET_QCOM_DISPLAY_VARIANT := legacy
BOARD_ADRENO_DECIDE_TEXTURE_TARGET := true

# Video
TARGET_QCOM_LEGACY_OMX := true
TARGET_QCOM_LEGACY_MMPARSER := true
TARGET_QCOM_MEDIA_VARIANT := legacy
#TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
COMMON_GLOBAL_CFLAGS += -DQCOM_NO_SECURE_PLAYBACK

# Qualcomm hardware
BOARD_USES_QCOM_HARDWARE := true
COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true

# WiFi
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WLAN_DEVICE := ath6kl
WIFI_DRIVER_MODULE_PATH := /system/wifi/ar6000.ko
WIFI_DRIVER_MODULE_NAME := ar6000
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_ath6kl

# Audio
TARGET_PROVIDES_LIBAUDIO := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/zte/p752d/bluetooth

# Camera
BOARD_NEEDS_MEMORYHEAPPMEM := true
COMMON_GLOBAL_CFLAGS += -DICS_CAMERA_BLOB -DZTE_CAMERA_HARDWARE

# Dalvik
TARGET_ARCH_LOWMEM := true

# FM Radio
BOARD_HAVE_QCOM_FM := true
COMMON_GLOBAL_CFLAGS += -DQCOM_FM_ENABLED

# GPS
BOARD_USES_QCOM_GPS := true
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := tureis
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 50000

# Webkit
ENABLE_WEBGL := true
TARGET_FORCE_CPU_UPLOAD := true

# Hardware tunables framework
BOARD_HARDWARE_CLASS := device/zte/p752d/cmhw/

# Recovery
TARGET_RECOVERY_FSTAB := device/zte/p752d/ramdisk/fstab.tureis
BOARD_HAS_NO_SELECT_BUTTON := true

# USB mounting
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun0/file
BOARD_UMS_LUNFILE := "/sys/devices/platform/msm_hsusb/gadget/lun0/file"

# default props
ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0
ADDITIONAL_DEFAULT_PROPERTIES += ro.allow.mock.location=0
ADDITIONAL_DEFAULT_PROPERTIES += ro.debuggable=1
ADDITIONAL_DEFAULT_PROPERTIES += persist.service.adb.enable=1
ADDITIONAL_DEFAULT_PROPERTIES += ro.config.sec_storage=1
ADDITIONAL_DEFAULT_PROPERTIES += persist.sys.usb.config=mass_storage,adb

BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12582912
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 234881024
BOARD_USERDATAIMAGE_PARTITION_SIZE := 170393600
BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_DATA_DEVICE := /dev/block/mtdblock6
BOARD_DATA_FILESYSTEM := yaffs2
BOARD_DATA_FILESYSTEM_OPTIONS := rw
BOARD_SYSTEM_DEVICE := /dev/block/mtdblock5
BOARD_SYSTEM_FILESYSTEM := yaffs2
BOARD_SYSTEM_FILESYSTEM_OPTIONS := rw
BOARD_CACHE_DEVICE := /dev/block/mtdblock4
BOARD_CACHE_FILESYSTEM := yaffs2
BOARD_CACHE_FILESYSTEM_OPTIONS := rw

## mtd table
#dev:    size   erasesize  name
#mtd0: 00c00000 00020000 "recovery"
#mtd1: 00800000 00020000 "boot"
#mtd2: 00180000 00020000 "splash"
#mtd3: 00080000 00020000 "misc"
#mtd4: 03980000 00020000 "cache"
#mtd5: 0e000000 00020000 "system"
#mtd6: 0a280000 00020000 "userdata"
#mtd7: 00100000 00020000 "oem"
#mtd8: 00180000 00020000 "persist"
#mtd9: 00140000 00020000 "mibib"
#mtd10: 000a0000 00020000 "qcsbl"
#mtd11: 00140000 00020000 "oemsbl1"
#mtd12: 00140000 00020000 "oemsbl2"
#mtd13: 01880000 00020000 "amss"
#mtd14: 000a0000 00020000 "appsbl"
