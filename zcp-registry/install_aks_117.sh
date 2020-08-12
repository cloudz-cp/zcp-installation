#!/bin/bash

# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=registry.aks-v117.cloudzcp.com
HARBOR_INGRESS_CONTROLLER=public-nginx
HARBOR_EXTERNAL_URL=https://registry.aks-v117.cloudzcp.com
HARBOR_ADMIN_PASSWORD=
HARBOR_AZURE_ACCOUNTNAME=
HARBOR_AZURE_ACCOUNTKEY=
HARBOR_AZURE_CONTAINER=cloudzcp-aks-v117-registry

# Install harbor
# Chart revision for harbor : https://github.com/goharbor/harbor-helm/tree/v1.0.1
helm3 repo add harbor https://helm.goharbor.io

helm3 install zcp-registry harbor/harbor --version 1.4.2 \
-f values-aks-117.yaml \
--namespace ${TARGET_NAMESPACE} \
--set expose.ingress.hosts.core=${HARBOR_INGRESS_HOSTS} \
--set expose.ingress.annotations."kubernetes\.io/ingress\.class"=${HARBOR_INGRESS_CONTROLLER} \
--set externalURL=${HARBOR_EXTERNAL_URL} \
--set harborAdminPassword=${HARBOR_ADMIN_PASSWORD} \
--set persistence.persistentVolumeClaim.jobservice.storageClass=file-standard \
--set persistence.persistentVolumeClaim.jobservice.size=20Gi \
--set persistence.persistentVolumeClaim.database.storageClass=managed-standard \
--set persistence.persistentVolumeClaim.database.size=5Gi \
--set persistence.persistentVolumeClaim.redis.storageClass=managed-standard \
--set persistence.persistentVolumeClaim.redis.size=5Gi \
--set persistence.imageChartStorage.azure.accountname=${HARBOR_AZURE_ACCOUNTNAME} \
--set persistence.imageChartStorage.azure.accountkey=${HARBOR_AZURE_ACCOUNTKEY} \
--set persistence.imageChartStorage.azure.container=${HARBOR_AZURE_CONTAINER} \
