#!/bin/bash
#
# Copyright 2013 Hewlett-Packard Development Company, L.P.
# All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

set -eux

while true; do
    source /opt/stack/tripleo-incubator/scripts/setup-env /opt/stack
    source /root/stackrc
    set +u
    devtest_overcloud.sh
    RESULT=$?
    set -u
    MSG=$(echo "************** overcloud complete status=$RESULT ************")
    echo $MSG
    send-irc tripleo cd-undercloud "$MSG"
    if [ "0" != "$RESULT" ]; then
        exit $RESULT
    fi
done