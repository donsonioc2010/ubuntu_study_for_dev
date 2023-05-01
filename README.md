# Study_For_Linux_By_DockerSample

> 해당 docker-compose는 리눅스를 처음 사용해보는 사람을 위해서 자주 사용하는 패키지를 Base로 설정한 docker-compose입니다.

---

## 사용방법

> 해당 파일을 사용하기 위해서는 `docker`와 `docker-compose`의 설치가 필요합니다. 해당 설치는 **docker 공식문서**를 통해서 설치를 하시기 바랍니다.

1. `docker-compose`파일이 있는 Directory로 이동
2. 설치 `docker-compose up -d`
3. container가 내려간 경우
   1. `docker-compose start`

---

## 이슈사항

1. Password Dockerfile에서 변경이 안됨...
   - 해결함
   - usermod와 echo를 통해서 변경 완료
2. PermitRootLogin 설정 변경해보고자 했는데 안됨...
   - 해결함
   - `/etc/ssh/sshd_config`설정파일의 `PermitRootLogin`속성 Yes처리
3. MariaDB 원격지 접속불가
   - 해결함
   - `/etc/mysql/mariadb.conf.d/50-server.cnf`설정 파일의 `bind-address` 항목 주석처리
4. `The last packet sent successfully to the server was 0 milliseconds ago`다음 문제 해결
   - 3번 문제가 기본 원인
   - Root계정의 경우 최초에 localhost만 생성되게 되어있어서 연결이 불가능함.
     - '%'권한의 계정 추가

---

## 접속방법

1. Docker명령어를 통한 접속
   1. `docker exec -it ${container_id} /bin/bash`
   2. `ssh -p 44444 root@localhost`
      1. 패스워드 입력

---

## 추가 필요한 설정

1. ~~Root 패스워드 설정(해결)~~
   1. `docker exec -it ${container_id} /bin/bash`접속
   2. `passwd root`이후 패스워드 변경
2. ~~Remote Root접속 허용 설정(해결)~~
   1. `docker exec -it ${container_id} /bin/bash`접속
   2. `vi /etc/ssh/sshd_config`
      1. `PermitRootLogin` 항목 주석 해제
      2. Value `yes`로 변경
3. Database User 생성 및 database생성

   1. mariadb접속
      1. `mysql -u root`, 이후 패스워드인 1234추가
   2. SQL입력

      1. ```SQL
         CREATE USER 'root'@'%' IDENTIFIED BY '1234';
         GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
         FLUSH PRIVILEGES;
         CREATE DATABASE {DATABASE_NAME};
         ```

   3. 본인이 입력한 DATABASE_NAME으로 연결테스트 진행

---

## Port 설정

| HostPort | ContainerPort | Description  |
| :------: | :-----------: | :----------- |
|  44444   |      22       | SSH Port     |
|   2525   |      25       | SMTP Port    |
|    80    |      80       | HTTP Port    |
|  11110   |      110      | POP3         |
|   443    |      443      | HTTPS Port   |
|  53306   |     3306      | MariaDB Port |

---

## Docker Image 방식으로 사용방법

1. docker build -t {name} .
2. docker run -it -d --privileged=true --name {imagename} /sbin/init
