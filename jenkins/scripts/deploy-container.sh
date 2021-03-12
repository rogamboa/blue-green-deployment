#!/bin/bash

AWS_ID=$(aws sts get-caller-identity | jq .Account | tr -d \")
REGION="us-east-1"

if  kubectl get rc $BRANCH_NAME-app > /dev/null 2>&1 ; then
  kubectl scale --replicas=0 rc/$BRANCH_NAME-app
fi

cat <<EOF | kubectl apply -f -
  apiVersion: v1
  kind: ReplicationController
  metadata:
    name: $BRANCH_NAME-app
  spec:
    replicas: 2
    selector:
      app: $BRANCH_NAME
    template:
      metadata:
        name: $BRANCH_NAME
        labels:
          app: $BRANCH_NAME
      spec:
        containers:
          - name: app
            image: $AWS_ID.dkr.ecr.$REGION.amazonaws.com/$REPO:build-$BRANCH_NAME
            imagePullPolicy: Always
            ports:
            - containerPort: 5000
        imagePullSecrets:
        - name: $SECRET_NAME
EOF