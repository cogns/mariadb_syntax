--dirty read 실습
--워크벤치에서 auto_commit해제후 update 실행 -> commit이 안된 상태 (임시저장)
--터미널을 열어서 select했을 때 위 변경사항이 변경됐는지 확인.


--phatom read 동시성 이슈 실습
--워크벤치에서 시간(do sleep)을 두고 2번의 select가 이뤄지고, 
--터미널에서 중간에 insert 실행 -> 2번의 select 결과값이 동일한지 확인
start transaction
select * from author;
do sleep(15);
select * from author;
commit;
--터미널에서 아래 insert문 실행
insert into author(name, email) values ('kim', 'kim@naver.com');


--lost update 이슈를 해결하기 위한 공유락(shared lock)
--워크벤치에서 아래 코드 실행
start transaction;
select post_count from author where id = 1 lock in share mode;
do sleep(15);
select post_count from author where id = 1 lock in share mode;
commit;

select post_count from author where id = 1;

--터미널에서 실행
select post_count from author where id = 1 lock in share mode;
update author set post_count =0 where id = 1;


--베타적 잠금(exclusive lock) : select for update
--select 부터 lock
start transaction;
select post_count from author where id = 1 for update;
do sleep(15);
select post_count from author where id = 1 for update;
commit;

--터미널에서 실행
select post_count from author where id = 1 for update;
update author set post_count =0 where id = 1;