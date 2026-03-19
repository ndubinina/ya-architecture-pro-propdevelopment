#!/bin/bash
set -e

create_user() {
  local USER=$1
  local NAMESPACE=$2

  echo "Create user $USER in namespace $NAMESPACE..."

  kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${USER}
  namespace: ${NAMESPACE}
EOF
  TOKEN=$(kubectl create token $USER -n $NAMESPACE)
  kubectl get secret $TOKEN -n ${NAMESPACE} -o jsonpath='{.data.token}' | base64 --decode

  echo "OK: TOKEN=$TOKEN - save it"
}

create_user "secret-owner" "default"
create_user "devops" "default"
create_user "dev" "default"
create_user "sre" "default"