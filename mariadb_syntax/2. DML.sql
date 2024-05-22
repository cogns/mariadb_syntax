--insert into : 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2, 데이터3);
-- id, name, email -> author 1건 추가 

--select : 데이터 조회, * : 모든컬럼조회
select * from author;

--id, title, content, author_id -> posts에 1건 추가

--테이블 제약조건 조회
select*from information_schema.key_column_usage where table_name = 'posts';

--실습 : insert문을 통해 author 데이터 4개정도 추가, post 데이터 5개 추가(1개정도는 익명)

--update 테이블명 set 컬럼명1 = 데이터1, 컬럼명2 = 데이터2 where id =1;
--where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의.
update author set email='abc@test.com';

update author set name = 'abc', email = 'abc@test.com' where id =1;
update author set email = 'abc@test.com' where id =2;


--delete from 테이블명 where 조건
--where 조건이 생략될 경우 모든 데이터가 삭제됨에 유의.
delete from 테이블명 where id =5;


--SELECT의 다양한 조회방법
select * from author where id =1;
select * from author where id >2 and name = 'rnjscogns3';

--특정 컬럼만을 조회할 때
select name, email from author where id = 3;


--중복 제거하고 조회
select distinct title from post;

-- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬조건없이 조회할 경우에는 pk(기본키) 기준으로 오름차순 정렬
-- asc : 오름차순, desc : 내림차순
select*from author order by name asc;

--멀티컬럼order by : 여러 컬럼으로 정렬, 먼저쓴 컬러 우선 정렬. 중복 시, 그 다음 정렬옵션 적용
select*from post order by title; --asc/desc 생략시 오름차순
select*from post order by title, id desc;


--limit number : 특정숫자로 결과값 개수 제한
select*from author order by id desc limit 1;

--alias(별칭)을 이용한 select : as 키워드 사용
select name as 이름, email as 이메일 from author;
select a.name as 이름, a.email as 이메일 from author as a;

--null을 조회조건으로
select * from post where author_id is null;
select * from post where author_id is not null;


--HAVING : group by를 통해 나온 통계에 대한 조건
select author_id, count(*) from post group by author_id;
