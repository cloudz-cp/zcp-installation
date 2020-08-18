. env.properties

kubectl create secret generic realm-secret -n ${TARGET_NAMESPACE} --from-file=realm-zcp-export.json

# Install postgresql for keycloak
# Chart revision for postgresql : https://github.com/bitnami/charts/tree/47b3f22873a2e622442ae7962d19a07b74b5de91/bitnami/postgresql
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install bitnami/postgresql --version 9.1.4 \
--name zcp-oidc-postgresql \
-f values-postgresql.yaml \
--namespace ${TARGET_NAMESPACE} \
--set postgresqlUsername=${KEYCLOAK_DB_USER} \
--set postgresqlPassword=${KEYCLOAK_DB_PWD} \
--set postgresqlDatabase=${KEYCLOAK_DB_NAME} \
--set persistence.enabled=true \
--set persistence.storageClass=ebs-gp2-retain \
--set persistence.size=5Gi

# Install keycloak
# Chart revision for keycloak : https://github.com/helm/charts/tree/577a48db1bb1fd6fa931b74f411b83526a598cb1/stable/keycloak
helm install stable/keycloak --version 4.0.2 \
--name zcp-oidc \
-f values-eks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set keycloak.username=${KEYCLOAK_ADMIN_ID} \
--set keycloak.password=${KEYCLOAK_ADMIN_PWD} \
--set keycloak.ingress.hosts[0]=${KEYCLOAK_INGRESS_HOSTS} \
--set keycloak.ingress.annotations."kubernetes\.io/ingress\.class"=${KEYCLOAK_INGRESS_CONTROLLER} \
--set keycloak.ingress.tls[0].hosts[0]=${KEYCLOAK_INGRESS_HOSTS} \
--set keycloak.ingress.tls[0].secretName=${DOMAIN_SECRET_NAME} \
--set keycloak.persistence.dbPassword=${KEYCLOAK_DB_PWD} \
#--set postgresql.postgresPassword=${KEYCLOAK_DB_PWD} \
#--set postgresql.persistence.enabled=true \
#--set postgresql.persistence.storageClass=efs-zcp \
#--set postgresql.persistence.size=5Gi
#--set keycloak.resources.limits.cpu=${KEYCLOAK_LIMIT_CPU} \
#--set keycloak.resources.limits.memory=${KEYCLOAK_LIMIT_MEM} \
#--set keycloak.resources.requests.cpu=${KEYCLOAK_REQUEST_CPU} \
#--set keycloak.resources.requests.memory=${KEYCLOAK_REQUEST_MEM} \
#--set postgresql.postgresUser=${KEYCLOAK_DB_USER} \
#--set postgresql.postgresDatabase=${KEYCLOAK_DB_NAME} \
#--set postgresql.persistence.enabled=true \
#--set postgresql.metrics.enabled=true \
#--set postgresql.persistence.existingClaim=${KEYCLOAK_DB_PVC_NAME}
