#!/bin/bash

./tools/wait-for-rollout.sh deployment istio-ingressgateway-1-15 istio-gateways 10 ${cluster_context}
#./tools/wait-for-rollout.sh deployment istio-eastwestgateway istio-gateways 10 ${cluster_context}