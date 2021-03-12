#!/bin/bash

CLUSTER_NAME=eks-example
REGION=us-east-1
KEY_NAME=example-key
INSTANCE_TYPE=t2.medium

eksctl create cluster \
  --name $CLUSTER_NAME \
  --region $REGION \
  --with-oidc \
  --ssh-access \
  --ssh-public-key $KEY_NAME \
  --node-type $INSTANCE_TYPE\
  --managed