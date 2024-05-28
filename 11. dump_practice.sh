# local에서 sql 덤프파일 생성
mysqldump -u root -p board > dumpfile.sql
# 한글 꺠질 때
mysqldump -uroot -p board -r dumpfile.sql


# dump파일을 github에 업로드
git add .
git commit -m "mariadb syntax"
git push origin main

git add .
git commit -m "SCRUM-2 회원가입추가"
git push origin main

# 리눅스에서 mariadb 서버 설치
sudo apt-get install mariadb-server

# mariadb 서버 시작
sudo systemctl status mariadb

# mariadb 접속 테스트
sudo mariadb -u root -p

# git 설치
sudo apt install git

# git을 통해 repo clone
git clone 래파지토리주소

mysql -u root -p board < dumpfile.sql
