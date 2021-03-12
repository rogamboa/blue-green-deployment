#!/bin/bash

URL="http://$(kubectl get service app-service -o custom-columns=EXTERNAL-IP:.status.loadBalancer.ingress[*].hostname | tail -n 1)"
if curl -s ${URL} | grep -q "Congratulations"
then
  exit 0
else
  exit 1
fi