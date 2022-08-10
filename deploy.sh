#!/bin/bash
#set -e

# replace the parameter below with your designated cluster context
# note that the character '_' is an invalid value
#
# please use `kubectl config rename-contexts <current_context> <target_context>` to
# rename your context if necessary
cluster_context="mgmt"

# check to see if defined contexts exist
if [[ $(kubectl config get-contexts | grep ${cluster_context}) == "" ]] ; then
  echo "Check Failed: ${cluster_context} context does not exist. Please check to see if you have the clusters available"
  echo "Run 'kubectl config get-contexts' to see currently available contexts. If the clusters are available, please make sure that they are named correctly. Default is ${cluster_context}"
  exit 1;
fi

# install argocd
cd bootstrap-argocd
./install-argocd.sh insecure-rootpath ${cluster_context}
cd ..

# wait for argo cluster rollout
./tools/wait-for-rollout.sh deployment argocd-server argocd 20 ${cluster_context}

# deploy cluster config aoa
kubectl apply -f platform-owners/${cluster_context}/${cluster_context}-cluster-config.yaml --context ${cluster_context}

# deploy infra app-of-apps
kubectl apply -f platform-owners/${cluster_context}/${cluster_context}-infra.yaml --context ${cluster_context}

# wait for completion of gloo-mesh install
./tools/wait-for-rollout.sh deployment gloo-mesh-mgmt-server gloo-mesh 10 ${cluster_context}

# deploy environment apps aoa
#kubectl apply -f platform-owners/${cluster_context}/${cluster_context}-apps.yaml --context ${cluster_context}

# deploy mesh config aoa
kubectl apply -f platform-owners/${cluster_context}/${cluster_context}-mesh-config.yaml --context ${cluster_context}

# echo port-forward commands
echo
echo "access gloo mesh dashboard:"
echo "kubectl port-forward -n gloo-mesh svc/gloo-mesh-ui 8090 --context ${cluster_context}"
echo 
echo "access argocd dashboard:"
echo "kubectl port-forward svc/argocd-server -n argocd 9999:443 --context ${cluster_context}"
echo

