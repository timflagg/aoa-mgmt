#!/bin/bash
cluster_context=$(kubectl config current-context)

./tools/wait-for-rollout.sh deployment gloo-mesh-mgmt-server gloo-mesh 10 ${cluster_context}