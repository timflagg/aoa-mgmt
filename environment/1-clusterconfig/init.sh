#!/bin/bash

echo "wave description:"
echo "namespaces, configmaps, secrets"
sleep 5

# create license
./tools/create-license.sh "${LICENSE_KEY}" "${cluster_context}"