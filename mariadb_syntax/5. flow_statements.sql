-- 흐름제어 : case문
SELECT 컬럼1, 컬럼2, 컬럼3,
CASE 컬럼4
    WHEN [비교값1] THEN 결과값1
    WHEN [결과값2] THEN 결과값2
    ELSE 결과값3
END
FROM 테이블명;

-- post테이블에서 1번 user는 first author, 2번 user는 author
select id, title, contents,
    case author_id
        when 1 then 'first author'
        when 2 then 'second author'
        else 'ohters'
    END
from post;

-- author_id가 있으면 그대로 출력 else author_id, 없으면 '익명사용자'로 출력 되도록 post테이블 조회
-- case에 꼭 컬럼이 들어가지 않아도 가능
select id, title, contents,
    case when author_id is null then '익명사용자' 
        else author_id end as author_id
    from post;

--위 케이스문을 ifnull구문으로 변환
select id, title, contents, ifnull(author_id, '익명사용자') as author_id from post;

--if구문으로 변환
select id, title, contents, if(author_id is not null, author_id, '익명사용자') as author_id from post;

