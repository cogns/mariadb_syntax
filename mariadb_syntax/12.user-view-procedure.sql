-- 사용자 관리

-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- %는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321';

-- 터미널에서 test1계정 로그인
mariadb -u test1 -p


--사용자에게 select 권한 부여
grant select on board.author to 'test1'@'localhost';

-- 권한 조회
show grants for 'test1'@'localhost';



-- test1으로 로그인한 후
select * from board.author;

-- UPDATE command denied to user 'test1'@'localhost' for table `board`.`author` 에러
update author set name='hi' where id=1;

-- 사용자 권한 회수
-- revoke는 from이다 헷갈리지 말기!
revoke select on board.author from 'test1'@'localhost';

-- 환경 설정을 변경 후 확정
-- 일반적으로 계정 생성, 권한 부여 후에는 
flush privileges;

-- 사용자 계정 삭제
drop user 'test1'@'localhost';




--------------
-- view

-- 뷰: 데이터베이스 테이블과 유사한 구조를 가지지만, 가상의 테이블로서 실제 데이터를 저장하지 않는 데이터베이스

-- 뷰 생성
create view author_for_marketing_team as
select name, age, role from author;

-- grant를 할 때, 쿼리 하나하나에 권한을 줄 수는 없다.
-- 따라서 view를 저장해 놓고, 해당 뷰에 접근할 권한을 주면 된다.

-- view 권한 부여
grant select on board.author_for_marketing_team to 'test1'@'localhost';

-- 뷰 변경(대체) -> 새로운 쿼리(뷰)로 갈아끼우는 거라고 보면 된다.
create or replace view author_for_marketing_team as
select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team;

-- 뷰의 활용 예시
-- 실무에 가면 매일 한번 조회해보고 시작하는 쿼리가 있을 수 있음
-- 만약 팀 단위로 자주쓰는 쿼리가 있다고 하면 뷰를 만들어놓을 수 있음

------------------------------------------------
-- 프로시저

-- 프로시저 생성
DELIMITER //
CREATE PROCEDURE test_procedure() -- 프로시저는 한글로도 이름 지정 가능
BEGIN
    SELECT 'hello world';
END
// DELIMITER ; -- 세미콜론 앞에 띄어쓰기 해줘야한다.

-- 프로시저 호출
call test_procedure();


-- 프로시저 지우기
drop procedure test_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN 
    SELECT * FROM POST;
END
// DELIMITER ;

--------------------------------------------------

-- 게시글 1건 상세 조회 -> 

DELIMITER //
CREATE PROCEDURE 게시글_단건_조회(IN post_id INT) -- 프로시저는 한글로도 이름 지정 가능
BEGIN
    SELECT * FROM post WHERE id = post_id; -- 왼쪽: 컬럼명, 오른쪽: 변수명
END
// DELIMITER ; -- 세미콜론 앞에 띄어쓰기 해줘야한다.


DELIMITER //
CREATE PROCEDURE 게시글_단건_조회(IN 저자아이디 INT, IN 제목 VARCHAR(255))
BEGIN
    SELECT * FROM post WHERE author_id = 저자아이디 AND title = 제목;
END
// DELIMITER ;
--------------------------------------------------

-- 프로시저 실습 - 글쓰기: title, contents, 저자 ID

DELIMITER //
CREATE PROCEDURE 글쓰기(IN 저자아이디 INT, IN 제목 VARCHAR(255), IN 내용 VARCHAR(3000))
BEGIN
    INSERT INTO post (author_id, title, contents) VALUES (저자아이디, 제목, 내용);
END
// DELIMITER ;


--------------------------------------------------

-- 글쓰기: title, contents, email
DELIMITER //
CREATE PROCEDURE 글쓰기(IN 저자아이디 INT, IN 제목 VARCHAR(255), IN 내용 VARCHAR(3000))
BEGIN
    INSERT INTO post (author_id, title, contents) VALUES (저자아이디, 제목, 내용);
END
// DELIMITER ;


--------------------------------------------------
-- 글쓰기: title, contents, email
DELIMITER //
CREATE PROCEDURE 글쓰기2(IN 이메일 varchar(255), IN 제목 VARCHAR(255), IN 내용 VARCHAR(3000))
BEGIN
    DECLARE 저자아이디 INT;
    SELECT id INTO 저자아이디 FROM author WHERE email = 이메일;
    INSERT INTO post (author_id, title, contents) VALUES (저자아이디, 제목, 내용);
END
// DELIMITER ;
--------------------------------------------------

-- sql에서 문자열 합치는 함수
-- concat('hell', ' world)
-- 글 상세 조회: input 값이 postId, 
-- title, contents, '홍길동' + '님'
DELIMITER //
CREATE PROCEDURE 글상세조회(IN 글아이디 INT)
BEGIN
    SELECT p.title 제목, p.contents 내용, CONCAT(a.name, '님') 저자 FROM post as p inner join author a on a.id = p.author_id WHERE p.id=글아이디;
END
// DELIMITER ;


-- 서브 쿼리로 풀기
DELIMITER //
CREATE PROCEDURE 글상세조회(IN 글아이디 INT)
BEGIN
    DECLARE 저자이름 VARCHAR(255);
    SELECT name INTO 저자이름 FROM AUTHOR WHERE id = (select author_id from post where id=글아이디);
    SELECT title, contents, concat(저자이름, '님') from post where id = 글아이디;
// DELIMITER ;


-------------------------------------------------------
-- 등급 조회
-- 글을 100개 이상 쓴 사용자는 고수입니다.
-- 글을 100 미만이면 중수입니다.
-- 그외는 초보입니다.
-- 입력 값: email
DELIMITER //
CREATE PROCEDURE 회원등급조회(IN 저자이메일 VARCHAR(255))
BEGIN
    DECLARE 글개수 INT;
    DECLARE 등급 VARCHAR(10);
    SELECT COUNT(*) INTO 글개수 FROM author WHERE email = 저자이메일;
    CASE WHEN 글개수 >= 100 THEN SELECT '고수입니다.';
         WHEN 글개수 >= 50 THEN SELECT '중수입니다.';
         ELSE SELECT '초보입니다.';
    END CASE;
END
// DELIMITER ;

------------------------------------ if-else로 풀기
DELIMITER //
CREATE PROCEDURE 회원등급조회2(IN 저자이메일 VARCHAR(255))
BEGIN
    DECLARE 글개수 INT;
    DECLARE 등급 VARCHAR(10);
    SELECT COUNT(*) INTO 글개수 FROM author WHERE email = 저자이메일;
    IF 글개수 >= 100 THEN
        SELECT '고수입니다.';
    ELSEIF 글개수 >= 50 THEN
        SELECT '중수입니다.';
    ELSE
        '초보입니다.';
    END IF;
END
// DELIMITER ;


--- 반복문을 통해 포스트 대량 생성
DELIMITER //
CREATE PROCEDURE 고수만들기(IN 저자이메일 VARCHAR(255))
BEGIN
    DECLARE 고수아이디 INT;
    INSERT INTO author (email, name) VALUES (저자이메일, '고수');
    SELECT id INTO 고수아이디 FROM author WHERE email = 저자이메일;
    FOR i IN 1..101 LOOP
        INSERT INTO post(author_id, title, contents) VALUES (고수아이디, '고수의 글', '고수의 글');
    END LOOP
END
// DELIMITER ;



--- while 문 예제
a = 0
while a < 10 do
  select '안녕'
  set a = a+1;
end while;

-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, 타이틀은 '안녕하세요'
DELIMITER //
CREATE PROCEDURE 글도배(IN 글개수 INT)
BEGIN
    DECLARE 현재글수 INT;
    SET 현재글수 = 0;
    WHILE 현재글수 < 글개수 DO
        INSERT INTO post (title) VALUES('안녕하세요');
        SET 현재글수 = 현재글수 + 1;
    END WHILE;
END
// DELIMITER ;

---- default로 기본값 설정하기
DELIMITER //
CREATE PROCEDURE 글도배2(IN 글개수 INT)
BEGIN
    DECLARE 현재글수 INT DEFAULT 0; -- 이렇게 기본값을 지정할 수 있다.
    -- SET 현재글수 = 0;
    WHILE 현재글수 < 글개수 DO
        INSERT INTO post (title) VALUES('안녕하세요2');
        SET 현재글수 = 현재글수 + 1;
    END WHILE;
END
// DELIMITER ;


---- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
grant execute on board.글도배 to 'test1'@'localhost';