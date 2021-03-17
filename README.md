# Blue Green Deployment

## Project Summary
This project demonstrates a CI/CD pipeline using a Blue/Green deployment strategy using Jenkins, Docker and kubernetes/EKS (using eksctl).

The sample Flask web app used in this project is sourced from [here](https://github.com/aws-samples/amazon-eks-cdk-blue-green-cicd).

Note: The pipeline relies on a kubernetes cluster pre-deployed outside of the pipeline. This implementation uses EKS and is deployed using eksctl.

## Project Contents
- ```flask-app``` - sample Flask web app files
- ```infrastructure```
  - ```deploy-eks.sh``` - script to deploy an EKS cluster using eksctl
  - ```cfn-template-sample/eks-cluster.yml``` - sample Cloudformation template of eks cluster stack
- ```jenkins```
  - ```Jenkinsfile``` - jenkins pipeline configuration file
  - ```scripts``` - contains scripts for pipeline

## Pipeline Workflow
Workflow found in ```jenkins/Jenkinsfile```
### Stages
- ```integration test```
  - Performs lint tests on web app and Dockerfile in ```flask-app```
    - uses ```scripts```: ```install-dependencies.sh``` and ```lint.sh```
- ```build image and push to repo```
  - Builds docker image according to Dockerfile and uploads image to ECR repository
- ```run kubeconfig```
  - Updates kubeconfig to allow for kubectl usage on eks cluster
### Following stages only executes on commits made to blue branch
- ```deploy blue container to eks cluster```
  - Deploys container to eks cluster using kubectl
  - uses ```scripts/deploy-container.sh```
- ```update service to redirect traffic blue environment```
  - Updates kubernetes service to point to blue containers
  - uses ```scripts/update-service.sh```
### Following stages only executes on commits made to green branch
- ```deploy green container to eks cluster```
  - Deploys container to eks cluster using kubectl
  - uses ```scripts/deploy-container.sh```
- ```update service to redirect traffic green environment```
  - Updates kubernetes service to point to green containers
  - uses ```scripts/update-service.sh```
### Stage only executes when a commit is made to either the blue branch or green branch
- ```perform smoke test```
  -  Performs curl test to confirm succesful deployment
  - uses ```scripts/smoke-test.sh```
