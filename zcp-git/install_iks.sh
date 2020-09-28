. env.properties

IMAGE_PULL_SECRET=

helm3 repo add zcp https://raw.githubusercontent.com/cnpst/charts/master/docs

# Install gitea
# Chart revision for jenkins : https://github.com/helm/charts/tree/605d3d441e6515fcbbf8a69bdc69794d90bbfd5c/stable/jenkins
helm3 install zcp-git zcp/zcp-gitea \
-f values-iks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set ingress.annotations."ingress\.bluemix\.net/ALB-ID"=${GITEA_INGRESS_CONTROLLER} \
--set ingress.hostname=${GITEA_INGRESS_HOSTS} \
--set ingress.tls[0].hosts[0]=${GITEA_INGRESS_TLS_HOSTS} \
--set ingress.tls[0].secretName=${DOMAIN_SECRET_NAME} \
--set persistence.storageClass=ibmc-file-silver \
--set images.gitea=registry.au-syd.bluemix.net/cloudzcp/gitea:1.11.5 \
--set images.memcached=registry.au-syd.bluemix.net/cloudzcp/memcached:1.5.19-alpine \
--set imagePullSecrets=${IMAGE_PULL_SECRET} \
--set mariadb.master.persistence.storageClass=ibmc-block-silver \
--set mariadb.image.registry=registry.au-syd.bluemix.net \
--set mariadb.image.repository=cloudzcp/mariadb \
--set mariadb.image.pullSecrets[0]=${IMAGE_PULL_SECRET} \
--set mariadb.tests.testFramework.image.registry=registry.au-syd.bluemix.net \
--set mariadb.tests.testFramework.image.repository=cloudzcp/bats \

