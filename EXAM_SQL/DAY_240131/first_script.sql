show databases;

select now();

create database testdb;

use testdb;

create table person(
person_id smallint unsigned,
fname varchar(20),
lname varchar(20),
eye_color enum('BR', 'BL', 'GR'),
birth_date date,
street varchar(30),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code varchar(20),
constraint pk_person primary key (person_id)
);

# person 테이블 확인
desc person;

create table favorite_food (
person_id smallint unsigned,
food varchar(20),
constraint pk_favorite_food primary key (person_id, food),
constraint fk_fav_food_person_id foreign key (person_id) references person(person_id)
);

# favorite_food 테이블 확인
desc favorite_food;

# person 테이블의 person_id 재정의
# person_id는 favorite_food에 외래키로 설정되어 있음
# 제약 조건을 먼저 해제한 후 변경해야 함, 그렇지 않다면 에러 발생
# 제약 조건 비활성화 -> 테이블 수정 -> 제약 조건 활성화
set foreign_key_checks=0;
alter table person modify person_id smallint unsigned auto_increment;	# 숫자 키 자동 증가 기능 추가
set foreign_key_checks=1;

desc person;

# 데이터 추가 : INSERT 문
insert into person
(person_id, fname, lname, eye_color, birth_date)
values (null, 'William', 'Turner', 'BR', '1972-05-27');	# null : auto_increment 속성 때문에 자동으로 숫자 증가

# 데이터 확인 : SELECT 문
select * from person;

# 데이터 확인 : SELECT 문 (특정 열만)
select person_id, fname, lname, birth_date from person;

# 데이터 확인 : SELECT 문 (+조건)
select person_id, fname, lname, birth_date from person
where lname='Turner';

# 데이터 추가 (한 번에 여러 개)
insert into favorite_food (person_id, food)
values (1, 'pizza'),
		(1, 'cookie'),
		(1, 'nachos');

# order by 컬럼이름 => 컬럼의 값을 알파벳 순서로 정렬
select food from favorite_food
where person_id = 1 order by food;

insert into person 
(person_id, fname, lname, eye_color, birth_date, street, city, state, country, postal_code)
values (null, 'Susan', 'Smith', 'BL', '1975-11-02', '23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

select person_id, fname, lname, birth_date from person;

# 데이터 수정 : UPDATE 문
update person
set street = '1225 Tremon St.',
	city = 'Boston',
	state = 'MA',
	country = 'USA',
	postal_code = '02138'
where person_id = 1;

select * from person;

# 데이터 삭제 : DELETE 문
delete from person
where person_id = 2;

# 테이블 삭제 : DROP 문
# drop table person;

select * from person;

# favorite_food의 person_id가 person의 person_id를 참조하므로,
# person의 person_id에 없는 값을 favorite_food의 person_id 값으로 추가할 수 없다.
insert into favorite_food (person_id, food)
values (3, 'lasagna');

select * from favorite_food;

# str_to_date(str, format) 함수 => 문자열을 format(형식 문자열)을 사용하여 DATETIME 값으로 변환 후 반환
update person
set birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
where person_id = 1;
