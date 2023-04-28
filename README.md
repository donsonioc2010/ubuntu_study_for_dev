# Bitcamp_Study_DockerSample

---

## 사용방법

> 해당 파일을 사용하기 위해서는 `docker`와 `docker-compose`의 설치가 필요합니다. 해당 설치는 **docker 공식문서**를 통해서 설치를 하시기 바랍니다.

1. `docker-compose up -d`

---

## 이슈사항

1. Password Dockerfile에서 변경이 안됨...
2. PermitRootLogin 설정 변경해보고자 했는데 안됨...

---

## 접속방법

1. Docker명령어를 통한 접속
   1. `docker exec -it ${container_id} /bin/bash`
   2. `ssh -p 2222 root@localhost`
      1. 패스워드 입력

---

## 추가 필요한 설정

1. Root 패스워드 설정
   1. `docker exec -it ${container_id} /bin/bash`접속
   2. `passwd root`이후 패스워드 변경
2. Remote Root접속 허용 설정
   1. `docker exec -it ${container_id} /bin/bash`접속
   2. `vi /etc/ssh/sshd_config`
      1. `PermitRootLogin` 항목 주석 해제
      2. Value `yes`로 변경

---

## Port 설정

| HostPort | ContainerPort | Description  |
| :------: | :-----------: | :----------- |
|   2222   |      22       | SSH Port     |
|   2525   |      25       | SMTP Port    |
|    80    |      80       | HTTP Port    |
|  11110   |      110      | POP3         |
|   443    |      443      | HTTPS Port   |
|  53306   |     3306      | MariaDB Port |
