#!/usr/bin/env bash
# Copyright 2020 Amazon.com Inc. or its affiliates. All Rights Reserved.
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

set -o errexit
set -o nounset
set -o pipefail

PROJECT_ROOT="$1"
OUTPUT_BIN_DIR="$2"
RELEASE_BRANCH="$3"

if [ ! -d ${OUTPUT_BIN_DIR} ] ;  then
    echo "${OUTPUT_BIN_DIR} not present! Run 'make binaries'"
    exit 1
fi

CHECKSUMS_FILE=$PROJECT_ROOT/CHECKSUMS

if [ -d $PROJECT_ROOT/$RELEASE_BRANCH ]; then
	CHECKSUMS_FILE=$PROJECT_ROOT/$RELEASE_BRANCH/CHECKSUMS
fi

rm -f $CHECKSUMS_FILE
for file in $(find ${OUTPUT_BIN_DIR} -type f | sort); do
    filepath=$(realpath --relative-base=$PROJECT_ROOT $file)
    sha256sum $filepath >> $CHECKSUMS_FILE
done

echo "*************** CHECKSUMS ***************"
cat $CHECKSUMS_FILE
echo "*****************************************"