# Ubuntu 22.04
FROM ubuntu:latest

# nginx, ssh, mariadb, jdk17
# jdk17의 경우 Spring Boot 3 Build시 최소 JDK17부터 지원하기때문
# JAVA_HOME의 경우 최초  JDK install할 경우 JAVA_HOME 알아서 지정함.
RUN apt-get update && \ 
    apt-get install -y \
    mariadb-server \
    nginx \
    openssh-server \
    openjdk-17-jdk \
    rdate \
    rename \
    gcc \
    g++ \
    tree \
    sqlite3 \
    glibc-doc \
    mandoc \
    apache2 \
    openssl \
    vim \ 
    locales
    
RUN apt-get update && \
    apt-get -y install sudo
    
# Locale 설정 추가
RUN locale-gen ko_KR.UTF-8

# Root의 패스워드 '1234'로 변경
RUN usermod --password $(echo '1234' | openssl passwd -1 -stdin) root

# Root계정을 SSH를 통해서 접속하기 위한 설정 변경
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# MariaDB의 원격 접속을 위한 bind-address 설정 해제
RUN sed -i 's/bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf


# Mariadb 설정파일, 데이터 디렉토리, 초기화 스크립트 경로
VOLUME /etc/mysql/conf.d
VOLUME /var/lib/mysql
VOLUME /docker-entrypoint-initdb.d

# Locale 환경 변수 설정, 한국어 사용을 위함
ENV TZ=Asia/Seoul
ENV LC_ALL=ko_KR.UTF-8
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR.UTF-8

# Mariadb 설정한 환경 변수들을 사용하도록 설정
ENV MYSQL_HOST=localhost
ENV MYSQL_PORT=3306
ENV MYSQL_ROOT_PASSWORD=1234


# Nginx의 경우에는 아직 제작안했기 때문에 주석처리를 하였으나 Nginx를 추후 설정하는 작업
# COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# MariaDB 설정파일 작업
COPY ./mariadb/conf.d/my.cnf /etc/mysql/my.cnf

COPY ./config/startup.sh .

# SSH, SMTP, HTTP, POP3, HTTPS, MariaDB Export 
EXPOSE 22 25 80 110 443 3306

CMD ["/bin/bash", "-c","startup.sh" ]