--not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

--auto_increment
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

--author.id에 제약조건 추가시 fk(기본키)로 인해 문제 발생시
--fk먼저 제거 이후에 author.id에 제약조건 추가
select*from information_schema.key_column_usage where table_name = 'post';
--삭제
alter table post drop foreign key post_ibfk_1;
--삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk foreign key (author_id) references author(id);


--uuid
alter table post add column user_id char(36) default(uuid()) ;


--unique 제약조건
alter table author modify column email varchar(255) unique;

--on delete cascade 테스트 -> 부모테이블의 id를 수정하면? 수정안됨(null값)
alter table post drop foreign key post_author_fk;

alter table post add constraint post_author_fk foreign key (author_id) 
references author(id) on delete cascade on update cascade ;

--(실습) delete는 set null, update cascade ->부모테이블의 id룰 수정하면? 같이 수정됨
alter table post add constraint post_author_fk foreign key (author_id) 
references author(id) on delete set null cascade on update cascade ;