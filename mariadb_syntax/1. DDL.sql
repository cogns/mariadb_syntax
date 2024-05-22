-- 데이터베이스 접속
mariadb -u root -p

--스키마(datebase) 목록조회
show databases;

--(스키마)데이터베이스 생성
CREATE DATABASE board; --명령문 : 대문자가 원칙

--데이터베이스 선택
use board;

--테이블 조회
show tables;

--author 테이블 생성
create table author( id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

--테이블 컬럼조회
describe author;

--컬럼 상세 조회
show full columns from author;

--테이블 생성문 조회
show create table author;

--posts테이블 신규 생성(id, title, content, author_id)
create table post(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT, foreign key(author_id) references author(id));

--테이블 index 조회
show index from 컬럼명;


--ALTER문 : 테이블의 구조를 변경
--테이블 이름 변경
alter table posts rename post;

--테이블 컬럼 추가
alter table author add column test1 varchar(50);

--테이블 컬럼 삭제
alter table author drop column test1;

-- 테이블 컬럼명 변경
alter table post change column content contents varchar(255);

--테이블 컬럼 타입과 제약조건 변경
alter table author modify column email varchar(255) not null;

--실습 : author 테이블에 address 컬럼 추가. varchar(255)
--실습 : post 테이블에 title은 not null제약조건 추가, contents는 3000자로 변경


--테이블 삭제
drop table 테이블명;