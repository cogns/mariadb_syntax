-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from post inner join author on author.id = post.author_id;
select * from author a inner join post p on a.id = p.author_id;


--글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

--모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
select p.id, p.title, p.contents, a.email from post p left join author a on p.author_id = a.id;


--join된 상황에서 where조건 : on 뒤에 where조건이 나옴
--1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상.
select p.title, a.email from author a inner join post p on p.author_id = a.id where age >=25;

--2)모든 글 목록 중에 title과 저자가 있다면 email을 출력, 2024-05-01이후에 만들어진 글만 출력
select p.title, a.email from post p left join author a on p.author_id = a.id where p.created_time >= '2024-05-01';


--조건에 맞는 도서와 저자 리스트 출력

--union : 중복제외한 두 테이블의 select을 결합(세로로 붙임)
--컬럼의 개수와 타입이 같아야함에 주의
--union all : 중복포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;

--author테이블의 name, email 그리고 post테이블의 title, contents union
select name, email from author union select title, contents from post;


--서브쿼리 : select문 안에 또 다른 select문을 서브쿼리라 한다.
--select절 안에 서브쿼리
--author email과 해당 author가 쓴 글의 개수를 출력
select email, (select count(*) from post p where p.author_id = a.id) from author a;

--from절 안에 서브쿼리
select a.mane from (select* from author) as a;

--where절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id; --이게 성능이 더 빠름
select * from author where id in (select author_id from post);

--없어진 기록 찾기 (프로그래머스 lv.3)문제 : join으로 풀 수 있는 문제, subquery로도 풀어보면 좋을것
select o.ANIMAL_ID, o.name --join풀이
from ANIMAL_OUTS o left join ANIMAL_INS i on o.ANIMAL_ID = i.ANIMAL_ID
where i.ANIMAL_ID is null
order by o.ANIMAL_ID; 

select ANIMAL_ID, NAME --subquery풀이
from ANIMAL_OUTS o 
where ANIMAL_ID not in (select ANIMAL_ID from ANIMAL_INS)
order by ANIMAL_ID;

--집계함수
select count(*) from author;
select sum(price) from post;
select round(avg(price), 0) from post; --round(a,2) a의 값을 소수점 2번째 자리까지 반올림

--group by와 집계함수
select author_id from post group by author_id;
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), round(avg(price), 0), min(price), max(price) 
from post group by author_id;


--저자, email, 해당저자가 작성한 글 수를 출력
select a.id, if(p.id is null, 0, count(*)) 
from author a left join post p on a.id = p.author_id group by a.id;


--where와 group by
--연도별 post 글 출력, 연도가 null인 데이터는 제외
select date_format(created_time, '%Y') year, count(*) count
from post 
where created_time is not null group by year;


--HAVING : group by를 통해 나온 통계에 대한 조건
select author_id, count(*) from post group by author_id;
--글을 2개이상 쓴 사람에 대한 통계정보
select author_id, count(*) as count from post where id>2 group by author_id having count>=2;

--(실습) 포스팅 price가 2000원 이상인 글을 대상으로, 
--      작성자 별로 몇건 인지와 평균 price를 구하되, 
--      평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id, round(avg(price), 0) avg_price from post 
where price >= 2000 group by author_id having avg_price >=3000;

--(실습) 2건 이상의 글을 쓴 사람의 email 와 count값을 구할건데,
--      나이는 25세 이상인 사람만 통계에 사용하고, 가장 나이 많은 사람 1명의 통계만 출력
select a.id, count(author_id) count from post p left join author a on p.author_id = a.id
where a.age >= 25 group by author_id having count(author_id) >= 2 order by age desc limit 1;


--다중열 group by
select author_id, title, count(*) from post group by author_id, title;

