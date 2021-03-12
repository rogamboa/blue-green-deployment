#!/bin/bash

cat <<EOF | kubectl apply -f -
  apiVersion: v1
  kind: Service
  metadata:
    name: app-service
  spec:
    selector:
      app: $BRANCH_NAME
    ports:
      - protocol: TCP
        port: 80
        targetPort: 5000
    type: LoadBalancer
EOF