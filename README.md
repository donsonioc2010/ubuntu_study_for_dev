Run : `docker-compose up -d`

# 컨테이너 내에서 service 명령어를 사용하여 각 서비스를 시작하고, tail -f /dev/null 명령어를 실행하여 컨테이너가 종료되지 않고 실행 상태로 유지되도록 설정했습니다.

command: bash -c "service nginx start && service ssh start && service mysql start && tail -f /dev/null"

id : root
pwd : 1234

ssh -p 2222 root@localhost
