. ./env.properties

# Install jenkins
# Chart revision for jenkins : https://github.com/helm/charts/tree/605d3d441e6515fcbbf8a69bdc69794d90bbfd5c/stable/jenkins
helm install jenkins-0.14.3-117.tgz --version 0.14.3 \
--name zcp-jenkins \
-f values-aks.yaml \
--namespace ${TARGET_NAMESPACE} \
--set Master.AdminUser=${JENKINS_ADMIN_ID} \
--set Master.AdminPassword=${JENKINS_ADMIN_PWD} \
--set Master.HostName=${JENKINS_INGRESS_HOSTS} \
--set Master.Ingress.Annotations."kubernetes\.io/ingress\.class"=${JENKINS_INGRESS_CONTROLLER} \
--set Master.Ingress.TLS[0].hosts[0]=${JENKINS_INGRESS_TLS_HOSTS} \
--set Master.Ingress.TLS[0].secretName=${DOMAIN_SECRET_NAME} \
--set Persistence.StorageClass=managed-standard-retain

kubectl create -f zcp-jenkins-maven-aks-pvc.yaml
