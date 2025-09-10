#!/bin/bash
# Script: describe_filtered_pod.sh
# Purpose: Grep pods by name in a namespace, pick the latest Running one, and describe it

if [ -z "$1" ]; then
  echo "❌ Usage: $0 <pod-name-pattern> [namespace]"
  exit 1
fi

POD_PATTERN=$1
NAMESPACE=${2:-egov}   # Default namespace is 'egov'

# Get the latest Running pod matching the pattern
LATEST_POD=$(kubectl get pods -n "$NAMESPACE" \
  --field-selector=status.phase=Running \
  --sort-by=.metadata.creationTimestamp \
  | grep "$POD_PATTERN" \
  | tail -n 1 \
  | awk '{print $1}')

if [ -z "$LATEST_POD" ]; then
  echo "❌ No Running pod found matching '$POD_PATTERN' in namespace '$NAMESPACE'"
  exit 1
fi

echo "📘 Latest running pod matching '$POD_PATTERN' in namespace $NAMESPACE: $LATEST_POD"
echo "🔍 Describing pod..."
echo "------------------------------------------------------------"

kubectl describe pod "$LATEST_POD" -n "$NAMESPACE"

