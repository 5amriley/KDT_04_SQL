/*
 * 2024/02/02 과제 연습 (SQL 3일차)
 */

# 1. 아래 2개의 테이블을 생성하고, 주어진 문제에 대한 sql문장을 작성하시오.

# 데이터베이스 생성
drop database if exists shoppingmall;
create database shoppingmall;

use shoppingmall;

# 외래키 여부 상관없이 테이블 삭제 가능하게 설정
set foreign_key_checks=0;

# 테이블 생성
drop table if exists user_table;

create table user_table (
	userID char(8),
	userName varchar(10) not null,
	birthYear int not null,
	addr char(2) not null,
	mobile1 char(3),
	mobile2 char(8),
	height smallint,
	mDate date,
	constraint pk_userid primary key (userID)
);

# 테이블 속성 확인
desc user_table;

# 테이블 입력
insert into user_table values
('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07'),
('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-03-03'),
('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08');

# 테이블 확인
select * from user_table;

# 테이블 생성
drop table if exists buy_table;
create table buy_table (
	num int auto_increment not null,
	userID char(8) not null,
	prodName char(6) not null,
	groupName char(4),
	price int not null,
	amount smallint not null,
	constraint pk_num primary key (num),
	constraint fk_userid foreign key (userID) references user_table(userID)
);

desc buy_table;

# 테이블 입력
insert into buy_table values
(null, 'KHD', '운동화', null, 30, 2),
(null, 'KHD', '노트북', '전자', 1000, 1),
(null, 'KYM', '모니터', '전자', 200, 1),
(null, 'PSH', '모니터', '전자', 200, 5),
(null, 'KHD', '청바지', '의류', 50, 3),
(null, 'PSH', '메모리', '전자', 80, 10),
(7, 'KJD', '책', '서적', 15, 5),
(8, 'LHJ', '책', '서적', 15, 2),
(9, 'LHJ', '청바지', '의류', 50, 1),
(10, 'PSH', '운동화', null, 30, 2),
(11, 'LHJ', '책', '서적', 15, 1),
(12, 'PSH', '운동화', null, 30, 2);

select * from buy_table;


# 2. 두 테이블을 내부 조인(buy_table.userID, user_table.userID)한 다음,
#    아래의 결과와 같이 출력이 되도록 SQL 쿼리를 작성하시오.

# 1) 내부 조인한 결과에 '연락처' 컬럼 추가
select ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) "연락처"
from buy_table bt 
	inner join user_table ut on bt.userID = ut.userID;

# 2) userID가 KYM 인 사람이 구매한 물건과 회원 정보 출력
select ut.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) "연락처"
from buy_table bt 
	inner join user_table ut on bt.userID = ut.userID
where ut.userID = 'KYM';

# 3) 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
select ut.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) "연락처"
from buy_table bt 
	inner join user_table ut on bt.userID = ut.userID
order by ut.userID;

# 4) 쇼핑몰에서 한 번이라도 구매한 기록이 있는 회원 정보를 회원 아이디 순으로 출력 (distinct 사용)
select distinct ut.userID, ut.userName, ut.addr
from buy_table bt 
	inner join user_table ut on bt.userID = ut.userID
order by ut.userID;

# 5) 쇼핑몰 회원 중에서 주소가 경북과 경남인 회원 정보를 회원 아이디 순으로 출력
select ut.userID, ut.userName, ut.addr, concat(mobile1, mobile2) "연락처"
from user_table ut
	inner join buy_table bt on bt.userID = ut.userID 
where addr in ('경북', '경남');

