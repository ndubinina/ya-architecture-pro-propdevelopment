#!/bin/bash

AUDIT_FILE=audit.log

echo "Secrets access:"
jq 'select(.objectRef.resource=="secrets" and (.verb=="get" or .verb=="list"))' $AUDIT_FILE

echo "Privileged pods:"
jq 'select(.objectRef.resource=="pods" and .verb=="create" and .requestObject.spec.containers != null and .requestObject.spec.containers[].securityContext.privileged==true)' $AUDIT_FILE

echo "kubectl exec:"
jq 'select(.objectRef.subresource=="exec" and .stage=="ResponseStarted")' $AUDIT_FILE

echo "RoleBinding create:"
jq 'select(.verb=="create" and .objectRef.resource=="rolebindings" and .requestObject.roleRef.kind=="ClusterRole")' $AUDIT_FILE
