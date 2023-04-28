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
    vim \ 
    locales
    
# Locale 설정 추가
RUN locale-gen ko_KR.UTF-8

# Locale 환경 변수 설정
ENV LC_ALL=ko_KR.UTF-8
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR.UTF-8

# Nginx설정파일, MariaDB설정파일 복사
# Nginx의 경우에는 아직 제작안했기 때문에 주석처리  
# COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# SSH 서버 설정 변경
RUN service ssh start && service nginx start


# SSH, SMTP, HTTP, POP3, HTTPS, MariaDB Export 
EXPOSE 22 25 80 110 443 3306

CMD ["/sbin/init"]