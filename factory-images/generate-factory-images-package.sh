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
# 235179 = ICL53F
# 299849 = IMM76D
# 330937 = IMM76I
# 397360 = JRO02C
# 398337 = JRO03C
# 477516 = JZO54I
# 485486 = JZO54K
# 526897 = JOP39B
# 527221 = JOP40
# 527662 = JOP40C
# 533553 = JOP40D
# 551245 = JDP82
# 573038 = JDQ39

source ../../../common/clear-factory-images-variables.sh
BUILD=573038
DEVICE=maguro
PRODUCT=yakju
VERSION=jdq39
SRCPREFIX=signed-
BOOTLOADER=primelc03
RADIO=i9250xxlj1
source ../../../common/generate-factory-images-common.sh

source ../../../common/clear-factory-images-variables.sh
BUILD=573038
DEVICE=maguro
PRODUCT=takju
VERSION=jdq39
SRCPREFIX=signed-
BOOTLOADER=primelc03
RADIO=i9250xxlj1
source ../../../common/generate-factory-images-common.sh
