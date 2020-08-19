. env.properties

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
--set mariadb.master.persistence.storageClass=ibmc-block-silver \
