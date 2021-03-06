#!/bin/bash

# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=
HARBOR_INGRESS_CONTROLLER=
HARBOR_EXTERNAL_URL=
DOMAIN_SECRET_NAME=cloudzcp-io-cert
HARBOR_ADMIN_PASSWORD=
HARBOR_S3_ACCESSKEY=
HARBOR_S3_SECRETKEY=
HARBOR_S3_BUCKET=

# Install harbor
helm3 repo add harbor https://helm.goharbor.io

helm3 install zcp-registry harbor/harbor --version 1.4.2 \
-f values-eks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set expose.ingress.hosts.core=${HARBOR_INGRESS_HOSTS} \
--set expose.ingress.annotations."kubernetes\.io/ingress\.class"=${HARBOR_INGRESS_CONTROLLER} \
--set externalURL=${HARBOR_EXTERNAL_URL} \
--set expose.tls.secretName=${DOMAIN_SECRET_NAME} \
--set harborAdminPassword=${HARBOR_ADMIN_PASSWORD} \
--set persistence.persistentVolumeClaim.jobservice.storageClass=efs-zcp-retain \
--set persistence.persistentVolumeClaim.jobservice.size=20Gi \
--set persistence.persistentVolumeClaim.database.storageClass=ebs-gp2-retain \
--set persistence.persistentVolumeClaim.database.size=5Gi \
--set persistence.persistentVolumeClaim.redis.storageClass=ebs-gp2-retain \
--set persistence.persistentVolumeClaim.redis.size=5Gi \
--set persistence.imageChartStorage.s3.accesskey=${HARBOR_S3_ACCESSKEY} \
--set persistence.imageChartStorage.s3.secretkey=${HARBOR_S3_SECRETKEY} \
--set persistence.imageChartStorage.s3.bucket=${HARBOR_S3_BUCKET} \
