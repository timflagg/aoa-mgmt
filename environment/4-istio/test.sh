#!/bin/bash
cluster_context="mgmt"

#./tools/wait-for-rollout.sh deployment istio-ingressgateway istio-gateways 10 ${cluster_context}
./tools/wait-for-rollout.sh deployment ingressgateway-ns-1-15 istio-gateways 10 ${cluster_context}
./tools/wait-for-rollout.sh deployment istio-eastwestgateway-1-15 istio-gateways 10 ${cluster_context}