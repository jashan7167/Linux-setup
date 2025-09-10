#!/bin/bash

# Usage: ./port-forward-latest.sh <keyword> [namespace]

# Input validation
if [ -z "$1" ]; then
  echo "❌ Usage: $0 <pod-name-keyword> [namespace]"
  exit 1
fi

KEYWORD="$1"
NAMESPACE="${2:-egov}"  # default to 'egov' if not provided

# Get the most recent pod matching the keyword
POD=$(kubectl get pods -n "$NAMESPACE" --sort-by=.status.startTime \
  | grep "$KEYWORD" | grep Running | tail -n 1 | awk '{print $1}')

if [ -z "$POD" ]; then
  echo "❌ No running pod found with keyword '$KEYWORD' in namespace '$NAMESPACE'"
  exit 1
fi

echo "✅ Found recent running pod: $POD"

# Prompt for local port only
read -p "Enter local port to forward from: " LOCAL_PORT

# Always use 8080 as container port
CONTAINER_PORT=8080

# Execute port-forward
echo "🔁 Starting port-forward: localhost:$LOCAL_PORT -> $POD:$CONTAINER_PORT"
kubectl port-forward "$POD" "$LOCAL_PORT:$CONTAINER_PORT" -n "$NAMESPACE"

