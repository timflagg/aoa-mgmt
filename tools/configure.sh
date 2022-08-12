#!/bin/bash
#set -e

# comma separated list
environment_overlays="cluster-config,infra,mesh-config"

# sed commands to replace target_branch variable
for i in $(echo ${environment_overlays} | sed "s/,/ /g"); do
  kubectl apply -f ../environment/${i}/${i}-aoa.yaml
done