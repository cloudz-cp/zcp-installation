# zcp-keycloak installation guide via Helm

## for IKS

### env.properties 파일 수정
env.properties 파일을 편집기로 열어 아래 항목을 프로젝트에 맞게 수정한다.

```
$ vi env.properties 
```

```
# target namespace installed
TARGET_NAMESPACE=zcp-system

# keycloak domain certificate secret name
DOMAIN_SECRET_NAME=cloudzcp-io-cert

# keycloak user account
KEYCLOAK_ADMIN_ID=cloudzcp-admin
KEYCLOAK_ADMIN_PWD=

# keycloak domain host
KEYCLOAK_INGRESS_HOSTS=iks-dev-iam.cloudzcp.io
KEYCLOAK_INGRESS_TLS_HOSTS=iks-dev-iam.cloudzcp.io
KEYCLOAK_INGRESS_CONTROLLER=private-***-alb1

# keycloak resources
#KEYCLOAK_LIMIT_CPU=800m
#KEYCLOAK_LIMIT_MEM=1024Mi
#KEYCLOAK_REQUEST_CPU=200m
#KEYCLOAK_REQUEST_MEM=1024Mi

# keycloak db config
KEYCLOAK_DB_VENDOR=POSTGRES
KEYCLOAK_DB_NAME=keycloak
KEYCLOAK_DB_HOST=zcp-oidc-postgresql
KEYCLOAK_DB_PORT=5432
KEYCLOAK_DB_USER=keycloak
KEYCLOAK_DB_PWD=
#KEYCLOAK_DB_PVC_NAME=zcp-oidc-postgresql
```

### Helm install 수행

```
$ ./install_iks.sh
```

## for EKS

### env.properties 파일 수정
env.properties 파일을 편집기로 열어 아래 항목을 프로젝트에 맞게 수정한다.

```
$ vi env.properties 
```

```
# target namespace installed
TARGET_NAMESPACE=zcp-system

# keycloak domain certificate secret name
DOMAIN_SECRET_NAME=cloudzcp-io-cert

# keycloak user account
KEYCLOAK_ADMIN_ID=cloudzcp-admin
KEYCLOAK_ADMIN_PWD=

# keycloak domain host
KEYCLOAK_INGRESS_HOSTS=eks-dev-iam.cloudzcp.io
KEYCLOAK_INGRESS_TLS_HOSTS=eks-dev-iam.cloudzcp.io
KEYCLOAK_INGRESS_CONTROLLER=private-nginx

# keycloak resources
#KEYCLOAK_LIMIT_CPU=800m
#KEYCLOAK_LIMIT_MEM=1024Mi
#KEYCLOAK_REQUEST_CPU=200m
#KEYCLOAK_REQUEST_MEM=1024Mi

# keycloak db config
KEYCLOAK_DB_VENDOR=POSTGRES
KEYCLOAK_DB_NAME=keycloak
KEYCLOAK_DB_HOST=zcp-oidc-postgresql
KEYCLOAK_DB_PORT=5432
KEYCLOAK_DB_USER=keycloak
KEYCLOAK_DB_PWD=
#KEYCLOAK_DB_PVC_NAME=zcp-oidc-postgresql
```

### Helm install 수행

```
$ ./install_eks.sh
```

## for AKS

### env.properties 파일 수정
env.properties 파일을 편집기로 열어 아래 항목을 프로젝트에 맞게 수정한다.

```
$ vi env.properties 
```

```
# target namespace installed
TARGET_NAMESPACE=zcp-system

# keycloak domain certificate secret name
DOMAIN_SECRET_NAME=cloudzcp-io-cert

# keycloak user account
KEYCLOAK_ADMIN_ID=cloudzcp-admin
KEYCLOAK_ADMIN_PWD=

# keycloak domain host
KEYCLOAK_INGRESS_HOSTS=aks-dev-iam.cloudzcp.io
KEYCLOAK_INGRESS_TLS_HOSTS=aks-dev-iam.cloudzcp.io
KEYCLOAK_INGRESS_CONTROLLER=private-nginx

# keycloak resources
#KEYCLOAK_LIMIT_CPU=800m
#KEYCLOAK_LIMIT_MEM=1024Mi
#KEYCLOAK_REQUEST_CPU=200m
#KEYCLOAK_REQUEST_MEM=1024Mi

# keycloak db config
KEYCLOAK_DB_VENDOR=POSTGRES
KEYCLOAK_DB_NAME=keycloak
KEYCLOAK_DB_HOST=zcp-oidc-postgresql
KEYCLOAK_DB_PORT=5432
KEYCLOAK_DB_USER=keycloak
KEYCLOAK_DB_PWD=
#KEYCLOAK_DB_PVC_NAME=zcp-oidc-postgresql
```

### Helm install 수행

```
$ ./install_aks.sh
```
