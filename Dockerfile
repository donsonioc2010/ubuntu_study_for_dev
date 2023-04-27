# Ubuntu 22.04
FROM ubuntu:latest

# nginx, ssh, mariadb, jdk17
# jdk17의 경우 Spring Boot 3 Build시 최소 JDK17부터 지원하기때문
# JAVA_HOME의 경우 최초  JDK install할 경우 JAVA_HOME 알아서 지정함.
RUN apt-get update && \ 
    apt-get install -y \
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
    vim
    
RUN usermod --password $(echo '1234' | openssl passwd -1 -stdin) root

# Nginx설정파일, MariaDB설정파일 복사
# Nginx의 경우에는 아직 제작안했기 때문에 주석처리
COPY ./mariadb/conf.d/my.cnf /etc/mysql/conf.d/my.cnf    
# COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

#MariaDB Data 외부로 보내기 위한 경로 추가
VOLUME /var/lib/mysql/data

# MariaDB의 bind-address 설정 해제
RUN sed -i 's/bind-address/#bind-address/' /etc/mysql/conf.d/my.cnf

# SSH, SMTP, HTTP, POP3, HTTPS, MariaDB Export 
EXPOSE 22 25 80 110 443 3306

# systemctl이 Docker에서 사용이 불가능함 해당명령어가 있어야 사용이 가능하다.
CMD ["/sbin/init"]