#!/bin/bash

echo "wave description:"
echo "namespaces, configmaps, secrets"
sleep 5

# create license
./tools/create-license.sh "${license_key}" "${cluster_context}"