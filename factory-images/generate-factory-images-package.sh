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

rm -rf tmp
mkdir -p tmp/yakju-itl41d
unzip -d tmp signed-yakju-target_files-223971.zip RADIO/radio.img RADIO/bootloader.img
cp signed-yakju-img-223971.zip tmp/yakju-itl41d/image-yakju-itl41d.zip
cp tmp/RADIO/bootloader.img tmp/yakju-itl41d/bootloader-maguro-primekj10.img
cp tmp/RADIO/radio.img tmp/yakju-itl41d/radio-maguro-i9250xxkk1.img
cp flash-all.sh tmp/yakju-itl41d
(cd tmp ; tar zcvf ../yakju-itl41d-factory.tgz yakju-itl41d)
mv yakju-itl41d-factory.tgz yakju-itl41d-factory-$(sha1sum < yakju-itl41d-factory.tgz | cut -b -8).tgz
rm -rf tmp
