#!/usr/bin/env bash
# Copyright Amazon.com Inc. or its affiliates. All Rights Reserved.
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


set -x
set -o errexit
set -o nounset
set -o pipefail

REPO="$1"

function build::plugins::licenses(){
  cd $REPO
  # Pull licenses for the plugins we are building, similiar logic exist in build_linux.sh called above
  # https://github.com/containernetworking/plugins/blob/master/build_linux.sh#L14
  PLUGINS="plugins/meta/* plugins/main/* plugins/ipam/*"
  ALL_PLUGINS=""
  for d in $PLUGINS; do
    if [ -d "$d" ]; then
      plugin="$(basename "$d")"
      if [ "${plugin}" != "windows" ]; then
        ALL_PLUGINS+="./$d "
      fi
    fi
  done
  echo "$ALL_PLUGINS"
}

build::plugins::licenses
