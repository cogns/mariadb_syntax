# local에서 sql 덤프파일 생성
mysqldump -u root -p board > dumpfile.sql
# 한글 꺠질 때
mysqldump -uroot -p board -r dumpfile.sql


# dump파일을 github에 업로드
git add.
git commit -m "mariadb syntax"
git push origin main