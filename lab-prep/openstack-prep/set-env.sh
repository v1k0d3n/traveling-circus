#!/bin/bash
# Copyright 2016, JinkIT, and it's Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Change these items as required for Openstack:
export OS_AUTH_URL=http://{{openstack_api_endpoint}}:5000/v3
export OS_TENANT_ID={{openstack_tenant_id}}
export OS_TENANT_NAME="admin"
export OS_PROJECT_NAME="admin"
export OS_USERNAME="admin"
#
# Change these items as required for the Traveling Circus:
export TC_KUBEPASS="kubepass"
export TC_LABADMPASS="adminpass"

# Should be no need to change the items below:
export LC_ALL=C
export CINDER_ENDPOINT_TYPE=internalURL
export NOVA_ENDPOINT_TYPE=internalURL
export OS_ENDPOINT_TYPE=internalURL
export OS_NO_CACHE=1
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_IDENTITY_API_VERSION=3
export OS_AUTH_VERSION=3
export OS_REGION_NAME="RegionOne"

# Force authentication to the Openstack cluster:
echo "Please enter your OpenStack Password: "
read -sr OS_PASSWORD_INPUT
export OS_PASSWORD=$OS_PASSWORD_INPUT
export OS_REGION_NAME="RegionOne"
if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi
