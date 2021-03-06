# The zcp-tools-backup Installation Guide

zcp-tools-backup 은 CronJob 기반의 백업 실행과 S3 전송 기능을 지원한다.

## Clone this project into the desktop
```
$ git clone https://github.com/cnpst/zcp-installation.git
```

## Deploy the application
프로젝트 별로 수정해야 하는 파일은 **values** 한 가지이다.

configuration 파일 디렉토리로 이동한다.

```
$ cd zcp-installation/zcp-tools-backup
```

### 1. values-ibm.yaml 정보 변경
`# CAHNGE` 주석이 포함된 라인의 정보를 수정한다.
```
...
# CHANGE
env:
  #AWS_ACCESS_KEY_ID: ***            # CHANGE
  #AWS_SECRET_ACCESS_KEY: ***        # CHANGE
  #S3_ENDPOINT: https://s3.***-ap-geo.objectstorage.softlayer.net  # CHANGE
  #S3_BUCKET: zcp-backup-***         # CHANGE
  GITEA_DEPLOY: zcp-git-gitea        # CHANGE

jenkins:
  schedule: 0 15 * * *  # CHANGEE
  ...
  serviceAccount:  # CHANGE
...

gitea:
  schedule: 0 15 * * *  # CHANGE
  ...
  serviceAccount:  # CHANGE
```

### 2. zcp-tools-backup 설치
아래의 helm install을 실행하고, 정상적으로 배포되었는지 확인한다. 
```
$ helm repo add zcp https://raw.githubusercontent.com/cnpst/charts/master/docs
$ helm install zcp/zcp-tools-backup --namespace zcp-system -n zcp-tools-backup -f values-ibm.yaml
$ kubectl get pod -n zcp-system
```

## zcp-keycloak-postgresql db dump backup cronjob 생성
### backup configmap 수정
manifest/postgresql 디레토리로 이동하여 configmap 설정 파일을 열어 S3 Credential 값을 수정한다.
```
$ cd manifest/postgresql
$ vi zcp-oidc-postgresql-backup-configmap.yaml
...
...
    export AWS_ACCESS_KEY_ID="xxxx"
    export AWS_SECRET_ACCESS_KEY="xxxx"
    export S3_ENDPOINT="https://s3.seo-ap-geo.objectstorage.service.networklayer.com"
    export S3_BUCKET="zcp-backup"
...
...
```

### backup cronjob 생성
```
$ ./kube_db_backup_create.sh
```

## CronJob 조회
```
$ kubectl get cronjob -n $NAMESPACE
NAME                         SCHEDULE             SUSPEND   ACTIVE    LAST SCHEDULE   AGE
zcp-oidc-postgresql-backup   5 16 * * *           False     0         1h              18h
```
