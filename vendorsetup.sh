#
# Copyright (C) 2022 The OrangeFox Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FDEVICE="zerolteusc"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	# Base
	export ALLOW_MISSING_DEPENDENCIES=true
	export LC_ALL="C"
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	
	# Exynos specific
	export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/15570000.ufs/by-name/RECOVERY"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/platform/15570000.ufs/by-name/SYSTEM"
	export FOX_RECOVERY_BOOT_PARTITION="/dev/block/platform/15570000.ufs/by-name/BOOT"
	export OF_DEVICE_WITHOUT_PERSIST=1
	
	# R11.1 Settings
	export FOX_R11=1
	export FOX_VERSION="R11.1"
	export FOX_BUILD_TYPE="Stable"
	export OF_MAINTAINER="gorkemoji"
	
	export FOX_ADVANCED_SECURITY=1
	export OF_USE_TWRP_SAR_DETECT=1
	export OF_VANILLA_BUILD=1
	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=0
	export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
	export OF_OTA_BACKUP_STOCK_BOOT_IMAGE=1
	export OF_DONT_PATCH_ON_FRESH_INSTALLATION=1
	export OF_SKIP_ORANGEFOX_PROCESS=1
	export OF_CHECK_OVERWRITE_ATTEMPTS=1
	export OF_SUPPORT_PRE_FLASH_SCRIPT=1
	export OF_RUN_POST_FORMAT_PROCESS=1

	# Quick Backup Defaults
	export OF_QUICK_BACKUP_LIST="/boot;/cache;/data;/system;"
	
	# Common
	export TARGET_ARCH=arm64
	export TW_DEFAULT_LANGUAGE="en"
	export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export FOX_USE_LZMA_COMPRESSION=1
	
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_ZIP_BINARY=1
	export FOX_REPLACE_BUSYBOX_PS=1
	export OF_USE_NEW_MAGISKBOOT=1
	export OF_ALLOW_DISABLE_NAVBAR=1
	export FOX_DISABLE_APP_MANAGER=1
	export OF_USE_GREEN_LED=0
	export OF_FL_PATH1="/etc/flashlight"
	export OF_FLASHLIGHT_ENABLE=1
	
	# Create Odin Flashable .tar files
	export OF_NO_SAMSUNG_SPECIAL=0

	# Let's See what are our Build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi

fi

add_lunch_combo omni_"$FDEVICE"-eng
add_lunch_combo omni_"$FDEVICE"-userdebug
