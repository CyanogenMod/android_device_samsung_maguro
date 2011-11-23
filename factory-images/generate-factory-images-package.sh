#!/bin/sh

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

# 223971 = ITL41D
# 228551 = ITL41F

BUILD=228551
VERSION=itl41f

rm -rf tmp
mkdir -p tmp/yakju-$VERSION
unzip -d tmp signed-yakju-target_files-$BUILD.zip RADIO/radio.img RADIO/bootloader.img
cp signed-yakju-img-$BUILD.zip tmp/yakju-$VERSION/image-yakju-$VERSION.zip
cp tmp/RADIO/bootloader.img tmp/yakju-$VERSION/bootloader-maguro-primekj10.img
cp tmp/RADIO/radio.img tmp/yakju-$VERSION/radio-maguro-i9250xxkk1.img
cp flash-all.sh tmp/yakju-$VERSION
(cd tmp ; tar zcvf ../yakju-$VERSION-factory.tgz yakju-$VERSION)
mv yakju-$VERSION-factory.tgz yakju-$VERSION-factory-$(sha1sum < yakju-$VERSION-factory.tgz | cut -b -8).tgz
rm -rf tmp
