# The zcp-registry Installation Guide

zcp-registry 은 Harbor 기반의 Private Docker Registry 이다.

zcp-registry 를 설치하기 이전에 https용 공인 인증서가 필요하다.

## Clone this project into the desktop
```
$ git clone https://github.com/cloudz-cp/zcp-installation.git
```

## Install helm v3
```
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ export BINARY_NAME=helm3
$ ./get_helm.sh
```

## Check helm3 version
```
$ helm3 version
```

## for IKS

### ENV 수정

```
$ vi install_iks.sh
```

```
# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=
HARBOR_NOTARY_INGRESS_HOSTS=
HARBOR_INGRESS_CONTROLLER=
# 상기 HARBOR_INGRESS_HOSTS 값 앞에 https:// 추가함.
# 예시) HARBOR_EXTERNAL_URL=https://registry.cloudzcp.io
HARBOR_EXTERNAL_URL=
DOMAIN_SECRET_NAME=cloudzcp-io-cert
HARBOR_ADMIN_PASSWORD=
HARBOR_S3_ACCESSKEY=
HARBOR_S3_SECRETKEY=
HARBOR_S3_BUCKET=
HARBOR_S3_REGIONENDPOINT=
IMAGE_REPOSITORY=registry.au-syd.bluemix.net/cloudzcp

```

### Helm install 수행

```
$ ./install_iks.sh
```

## for EKS

### ENV 수정

```
$ vi install_eks.sh
```

```
# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=
HARBOR_NOTARY_INGRESS_HOSTS=
HARBOR_INGRESS_CONTROLLER=
# 상기 HARBOR_INGRESS_HOSTS 값 앞에 https:// 추가함.
# 예시) HARBOR_EXTERNAL_URL=https://registry.cloudzcp.io
HARBOR_EXTERNAL_URL=
DOMAIN_SECRET_NAME=cloudzcp-io-cert
HARBOR_ADMIN_PASSWORD=
HARBOR_S3_ACCESSKEY=
HARBOR_S3_SECRETKEY=
HARBOR_S3_BUCKET=

```

### Helm install 수행

```
$ ./install_eks.sh
```

## for AKS

### ENV 수정

```
$ vi install_aks.sh
```

```
# variables
TARGET_NAMESPACE=zcp-system
HARBOR_INGRESS_HOSTS=
HARBOR_NOTARY_INGRESS_HOSTS=
HARBOR_INGRESS_CONTROLLER=
# 상기 HARBOR_INGRESS_HOSTS 값 앞에 https:// 추가함.
# 예시) HARBOR_EXTERNAL_URL=https://registry.cloudzcp.io
HARBOR_EXTERNAL_URL=
DOMAIN_SECRET_NAME=cloudzcp-io-cert
HARBOR_ADMIN_PASSWORD=
HARBOR_AZURE_ACCOUNTNAME=
HARBOR_AZURE_ACCOUNTKEY=
HARBOR_AZURE_CONTAINER=

```

### Helm install 수행

```
$ ./install_aks.sh
```
