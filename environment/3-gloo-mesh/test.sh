#!/bin/bash

while ! kubectl wait --for condition=established --timeout=60s crd/kubernetesclusters.admin.gloo.solo.io ; do sleep 5 done

kubectl apply --context ${cluster_context} -f- <<EOF
apiVersion: admin.gloo.solo.io/v2
kind: KubernetesCluster
metadata:
  name: mgmt
  namespace: gloo-mesh
spec:
  clusterDomain: cluster.local
EOF

./tools/wait-for-rollout.sh deployment ext-auth-service gloo-mesh-addons 10 ${cluster_context}
./tools/wait-for-rollout.sh deployment rate-limiter gloo-mesh-addons 10 ${cluster_context}
./tools/wait-for-rollout.sh deployment redis gloo-mesh-addons 10 ${cluster_context}

