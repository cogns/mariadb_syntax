-- tinyint는 -128~127까지 표현
-- author테이블에 age컬럼 추가. 
alter table author add column age tinyint;

--(insert시에 age : 200 -> 125)
insert into author(id, email, age) values (5, 'hello@naer.com', 130);
insert into author(id, email, age) values (5, 'hello@naer.com', 125);

--unsigned시에 255까지 표현범위 확대
alter table author modify column age tinyint unsigned;


--decimal실습
alter table post add column price decimal(10,3);

--decial 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, price) values(6, 'hello java', 3.123123);
--update : price를 1234.1
update post set price = 1234.1 where id = 8;


--blob 바이너리데이터 실습
--author테이블에 profile_image컬럼을 blob형식으로 추가
alter table author add column profile_image longblob;
insert into author(id, email, profile_image) values (7, 'cogns@naver.com', load_file("C:\Users\rnjsc\Desktop\다운로드.jpg"));


--enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
alter table author add column role enum('admin', 'user') not null default 'user';
--enum컬럼 실습
--user1을 insert =>에러
--user 또는 damin insert =>정상


--date 타입
--author테이블에 birth_day 컬럼을 date로 추가
--날짜 타입의 insert는 문자열 형식으로 insert (0000-00-00) st.
alter table author add column birth_day date;
insert into author(id, email, birth_day) values(15, 'cogns2@naver.com', '1999-11-03');

--datetime 타입
--author, post 둘다 datetime으로 created_time 컬럼추가
alter table author add column created_time datetime default current_timestamp;
alter table post add column created_time datetime  default current_timestamp;

insert into author(id, email) values(16, 'cogns2@naver.com');
insert into post(id, title) values(10, 'hello');



--비교연산자
--and 또는 &&
select * from post where id >=2 and id <=4;
select * from post where id between 2 and 4; -- 위 명령문이랑 같은 결과
--or 또는 ||
--not 또는 !
select * from post where id <2 or id >4;
--NULL인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;
--in(리스트형태), not in(리스트형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);

--like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o'; --o로 끝나는 title 검색
select * from post where title like 'h%'; --h로 시작하는 title 검색
select * from post where title like '%llo%'; --단어의 주안에 llo라는 키워드가 있는 경우 검색
select * from post where title not like '%o'; --o로 끝나는 title이 아닌 title 검색

--ifnull(a,b) : 만약에 a가 null이면 b반환, null이 아니면 b반환
select title, contents, ifnull(author_id, '익명') as 저자 from post;

--REGEXP : 정규표현식을 활용한 조회
select * from author where name regexp '[a-z]';
select * from author where name regexp '[가-힣]';

--날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
--CAST와 CONVERT
select cast(20200101 as date);
select cast('20200101' as date);

select convert (20200101 , date);
select convert('20200101', date);

--datetime 조회방법
select * from post where created_time like '2024-05%';
select * from post where created_time <= '2024-12-31' and created_time >= '1999-01-01' ;
select * from post where created_time between '2024-12-31' and '1999-01-01' ;
--date_formet
select date_format(created_time, '%Y-%m-%d') from post;
--실습 post를 조회할떄 date_formet활용하여 2024년 데이터 조회, 결과는 *
select * from post where date_format(created_time, '%Y') = '2024';

--오늘 날짜 
select now();