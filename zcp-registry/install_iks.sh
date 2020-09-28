#!/bin/bash

# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=
HARBOR_NOTARY_INGRESS_HOSTS=
HARBOR_INGRESS_CONTROLLER=
HARBOR_EXTERNAL_URL=
DOMAIN_SECRET_NAME=cloudzcp-io-cert
HARBOR_ADMIN_PASSWORD=
HARBOR_S3_ACCESSKEY=
HARBOR_S3_SECRETKEY=
HARBOR_S3_BUCKET=
HARBOR_S3_REGIONENDPOINT=
IMAGE_PULL_SECRET=

# Install harbor
helm3 repo add harbor https://helm.goharbor.io

helm3 install zcp-registry harbor/harbor --version 1.4.2 \
-f values-iks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set expose.ingress.hosts.core=${HARBOR_INGRESS_HOSTS} \
--set expose.ingress.hosts.notary=${HARBOR_NOTARY_INGRESS_HOSTS} \
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
--set imagePullSecrets[0].name=${IMAGE_PULL_SECRET} \
--set nginx.image.repository=registry.au-syd.bluemix.net/cloudzcp/nginx-photon \
--set portal.image.repository=registry.au-syd.bluemix.net/cloudzcp/harbor-portal \
--set core.image.repository=registry.au-syd.bluemix.net/cloudzcp/harbor-core \
--set jobservice.image.repository=registry.au-syd.bluemix.net/cloudzcp/harbor-jobservice \
--set registry.registry.image.repository=registry.au-syd.bluemix.net/cloudzcp/registry-photon \
--set registry.controller.image.repository=registry.au-syd.bluemix.net/cloudzcp/harbor-registryctl \
--set chartmuseum.image.repository=registry.au-syd.bluemix.net/cloudzcp/chartmuseum-photon \
--set clair.clair.image.repository=registry.au-syd.bluemix.net/cloudzcp/clair-photon \
--set clair.adapter.image.repository=registry.au-syd.bluemix.net/cloudzcp/clair-adapter-photon \
--set trivy.image.repository=registry.au-syd.bluemix.net/cloudzcp/trivy-adapter-photon \
--set notary.server.image.repository=registry.au-syd.bluemix.net/cloudzcp/notary-server-photon \
--set notary.signer.image.repository=registry.au-syd.bluemix.net/cloudzcp/notary-signer-photon \
--set database.internal.image.repository=registry.au-syd.bluemix.net/cloudzcp/harbor-db \
--set redis.internal.image.repository=registry.au-syd.bluemix.net/cloudzcp/redis-photon \
