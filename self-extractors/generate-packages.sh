#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
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

# 223971 = ITL41D
# 228551 = ITL41F
# 236517 = IML70C
# 237179 = IML73
# 237867 = IML74B
# 238432 = IML74E
# 238649 = IML74G
# 239410 = IML74K
# 257829 = IMM30B
# 262866 = IMM30D
# 299849 = IMM76D
# end ics-mr1
# start jb-dev
# 241580 = IRL89
# 241968 = IRM03
# 391496 = JRN83D
# 397816 = JRO03B
# 398337 = JRO03C
# 405518 = JRO03H
# 438695 = JRO03R
# 463694 = JZO54G
# 485486 = JZO54K
# end jb-dev
# start jb-mr1-dev
# 465036 = JOO75
# 521994 = JOP32B
# 524024 = JOP36
# 527221 = JOP40
# 527662 = JOP40C
# end jb-mr1-dev
# start jb-mr1.1-dev
# 551245 = JDP82
# 573038 = JDQ39
# end jb-mr1.1-dev
BRANCH=jb-mr1.1-dev
if test $BRANCH = ics-mr1
then
  ZIP=yakju-ota-299849.zip
  BUILD=imm76d
fi # ics-mr1
if test $BRANCH = jb-dev
then
  ZIP=yakju-ota-485486.zip
  BUILD=jzo54k
fi # jb-dev
if test $BRANCH = jb-mr1-dev
then
  ZIP=yakju-ota-527662.zip
  BUILD=jop40c
fi # jb-mr1-dev
if test $BRANCH = jb-mr1.1-dev
then
  ZIP=yakju-ota-573038
  BUILD=jdq39
fi # jb-mr1.1-dev
ROOTDEVICE=maguro
DEVICE=maguro
MANUFACTURER=samsung

for COMPANY in broadcom imgtec invensense nxp samsung widevine # csr ti
do
  echo Processing files from $COMPANY
  rm -rf tmp
  FILEDIR=tmp/vendor/$COMPANY/$DEVICE/proprietary
  mkdir -p $FILEDIR
  mkdir -p tmp/vendor/$MANUFACTURER/$ROOTDEVICE
  case $COMPANY in
  broadcom)
    TO_EXTRACT="\
            system/vendor/firmware/bcm4330.hcd \
            "
    ;;
  csr)
    TO_EXTRACT="\
            system/vendor/etc/sirfgps.conf \
            system/vendor/lib/hw/gps.omap4.so \
            "
    ;;
  imgtec)
    TO_EXTRACT="\
            system/vendor/bin/pvrsrvctl \
            system/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so \
            system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so \
            system/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so \
            system/vendor/lib/hw/gralloc.omap4.so \
            system/vendor/lib/libglslcompiler.so \
            system/vendor/lib/libIMGegl.so \
            system/vendor/lib/libpvr2d.so \
            system/vendor/lib/libpvrANDROID_WSEGL.so \
            system/vendor/lib/libPVRScopeServices.so \
            system/vendor/lib/libsrv_init.so \
            system/vendor/lib/libsrv_um.so \
            system/vendor/lib/libusc.so \
            "
    ;;
  invensense)
    TO_EXTRACT="\
            system/vendor/lib/libinvensense_mpl.so \
            "
    ;;
  nxp)
    TO_EXTRACT="\
            system/vendor/firmware/libpn544_fw.so \
            "
    ;;
  samsung)
    TO_EXTRACT="\
            system/bin/fRom \
            system/lib/libsecril-client.so \
            system/vendor/lib/libsec-ril.so \
            "
    ;;
  ti)
    TO_EXTRACT="\
            system/vendor/firmware/ducati-m3.bin \
            "
    ;;
  widevine)
    TO_EXTRACT="\
            system/lib/libdrmdecrypt.so \
            "
    ;;
  esac
  echo \ \ Extracting files from OTA package
  for ONE_FILE in $TO_EXTRACT
  do
    echo \ \ \ \ Extracting $ONE_FILE
    unzip -j -o $ZIP $ONE_FILE -d $FILEDIR > /dev/null || echo \ \ \ \ Error extracting $ONE_FILE
    if test $ONE_FILE = system/vendor/bin/gpsd -o $ONE_FILE = system/vendor/bin/pvrsrvinit -o $ONE_FILE = system/bin/fRom
    then
      chmod a+x $FILEDIR/$(basename $ONE_FILE) || echo \ \ \ \ Error chmoding $ONE_FILE
    fi
  done
  echo \ \ Setting up $COMPANY-specific makefiles
  cp -R $COMPANY/staging/* tmp/vendor/$COMPANY/$DEVICE || echo \ \ \ \ Error copying makefiles
  echo \ \ Setting up shared makefiles
  cp -R root/* tmp/vendor/$MANUFACTURER/$ROOTDEVICE || echo \ \ \ \ Error copying makefiles
  echo \ \ Generating self-extracting script
  SCRIPT=extract-$COMPANY-$DEVICE.sh
  cat PROLOGUE > tmp/$SCRIPT || echo \ \ \ \ Error generating script
  cat $COMPANY/COPYRIGHT >> tmp/$SCRIPT || echo \ \ \ \ Error generating script
  cat PART1 >> tmp/$SCRIPT || echo \ \ \ \ Error generating script
  cat $COMPANY/LICENSE >> tmp/$SCRIPT || echo \ \ \ \ Error generating script
  cat PART2 >> tmp/$SCRIPT || echo \ \ \ \ Error generating script
  echo tail -n +$(expr 2 + $(cat PROLOGUE $COMPANY/COPYRIGHT PART1 $COMPANY/LICENSE PART2 PART3 | wc -l)) \$0 \| tar zxv >> tmp/$SCRIPT || echo \ \ \ \ Error generating script
  cat PART3 >> tmp/$SCRIPT || echo \ \ \ \ Error generating script
  (cd tmp ; tar zc --owner=root --group=root vendor/ >> $SCRIPT || echo \ \ \ \ Error generating embedded tgz)
  chmod a+x tmp/$SCRIPT || echo \ \ \ \ Error generating script
  ARCHIVE=$COMPANY-$DEVICE-$BUILD-$(md5sum < tmp/$SCRIPT | cut -b -8 | tr -d \\n).tgz
  rm -f $ARCHIVE
  echo \ \ Generating final archive
  (cd tmp ; tar --owner=root --group=root -z -c -f ../$ARCHIVE $SCRIPT || echo \ \ \ \ Error archiving script)
  rm -rf tmp
done
