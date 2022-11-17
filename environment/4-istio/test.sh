#!/bin/bash

./tools/wait-for-rollout.sh deployment istio-ingressgateway istio-gateways 10 ${cluster_context}
#./tools/wait-for-rollout.sh deployment istio-eastwestgateway istio-eastwest 10 ${cluster_context}