#!/bin/bash

# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=registry.iks-v117.cloudzcp.com
HARBOR_INGRESS_CONTROLLER=public-crbsocltjt08l1jo5flhag-alb1
HARBOR_EXTERNAL_URL=https://registry.iks-v117.cloudzcp.com
DOMAIN_SECRET_NAME=cloudzcp-io-cert
HARBOR_ADMIN_PASSWORD=
HARBOR_S3_ACCESSKEY=
HARBOR_S3_SECRETKEY=
HARBOR_S3_BUCKET=zcp-iks-v117-registry
HARBOR_S3_REGIONENDPOINT=s3.ap.cloud-object-storage.appdomain.cloud

# Install harbor
helm3 repo add harbor https://helm.goharbor.io

helm3 install zcp-registry harbor/harbor --version 1.4.2 \
-f values-iks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set expose.ingress.hosts.core=${HARBOR_INGRESS_HOSTS} \
--set expose.ingress.annotations."ingress\.bluemix\.net/ALB-ID"=${HARBOR_INGRESS_CONTROLLER} \
--set externalURL=${HARBOR_EXTERNAL_URL} \
--set expose.tls.secretName=${DOMAIN_SECRET_NAME} \
--set harborAdminPassword=${HARBOR_ADMIN_PASSWORD} \
--set persistence.persistentVolumeClaim.jobservice.storageClass=ibmc-block-retain-silver \
--set persistence.persistentVolumeClaim.jobservice.size=20Gi \
--set persistence.persistentVolumeClaim.database.storageClass=ibmc-block-retain-silver \
--set persistence.persistentVolumeClaim.database.size=20Gi \
--set persistence.persistentVolumeClaim.redis.storageClass=ibmc-block-retain-silver \
--set persistence.persistentVolumeClaim.redis.size=20Gi \
--set persistence.imageChartStorage.s3.accesskey=${HARBOR_S3_ACCESSKEY} \
--set persistence.imageChartStorage.s3.secretkey=${HARBOR_S3_SECRETKEY} \
--set persistence.imageChartStorage.s3.bucket=${HARBOR_S3_BUCKET} \
--set persistence.imageChartStorage.s3.regionendpoint=${HARBOR_S3_REGIONENDPOINT} \
