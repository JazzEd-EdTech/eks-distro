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

TAG="$1"
BIN_PATH="$2"
OS="$3"
ARCH="$4"

SUFFIX=""
if [ $OS == "windows" ];
then
	SUFFIX=".exe"
fi
REV=`git rev-list -n1 HEAD`
LDFLAGS="-buildid='' -s -w -X main.version=$TAG -X main.commit=$REV"

CGO_ENABLED=0 GOOS=$OS GOARCH=$ARCH \
	go build -trimpath -ldflags "$LDFLAGS" \
	-o $BIN_PATH/aws-iam-authenticator$SUFFIX ./cmd/aws-iam-authenticator/
