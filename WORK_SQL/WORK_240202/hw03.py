"""
    2024/02/02 과제
    변주영
"""

import pymysql


def print_by_rows(rows):
    for row in rows:
        print(row)
    print()


# MySQL에 연결
conn = pymysql.connect(host='localhost', user='root',
                       password='2018',
                       db='shoppingmall', charset='utf8')

# cursur 객체 생성
curs = conn.cursor()

# 외래키 여부 상관없이 테이블 삭제 가능하게 설정
curs.execute('set foreign_key_checks=0')
conn.commit()

# user_table 테이블 생성
curs.execute("drop table if exists user_table")
conn.commit()

curs.execute("""create table user_table (
	userID char(8),
	userName varchar(10) not null,
	birthYear int not null,
	addr char(2) not null,
	mobile1 char(3),
	mobile2 char(8),
	height smallint,
	mDate date,
	constraint pk_userid primary key (userID)
)""")
conn.commit()

# user_table 테이블 입력
curs.execute("""insert into user_table values
('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07'),
('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-03-03'),
('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08')""")
conn.commit()

# buy_table 테이블 생성
curs.execute("drop table if exists buy_table")
curs.execute("""create table buy_table (
	num int auto_increment not null,
	userID char(8) not null,
	prodName char(6) not null,
	groupName char(4),
	price int not null,
	amount smallint not null,
	constraint pk_num primary key (num),
	constraint fk_userid foreign key (userID) references user_table(userID)
)""")
conn.commit()

# buy_table 테이블 입력
curs.execute("""insert into buy_table values
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
(12, 'PSH', '운동화', null, 30, 2)""")
conn.commit()

# ---------------------------------------------------------
# 문제 출력
# ---------------------------------------------------------

print('문제 1번')
print('-'*40)
print('userName  prodName  addr   연락처')
print('-'*40)

curs.execute("""select ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) "연락처"
from buy_table bt 
	inner join user_table ut on bt.userID = ut.userID""")
rows = curs.fetchall()
print_by_rows(rows)

print('문제 2번')
print('-'*50)
print('userID  userName prodName  addr   연락처')
print('-'*50)

curs.execute("""select ut.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) "연락처"
from buy_table bt 
	inner join user_table ut on bt.userID = ut.userID
where ut.userID = 'KYM'""")
rows = curs.fetchall()
print_by_rows(rows)

print('문제 3번')
print('-'*50)
print('userID  userName prodName  addr   연락처')
print('-'*50)

curs.execute("""select ut.userID, ut.userName, bt.prodName, ut.addr, concat(ut.mobile1, ut.mobile2) "연락처"
from buy_table bt 
	inner join user_table ut on bt.userID = ut.userID
order by ut.userID""")
rows = curs.fetchall()
print_by_rows(rows)

print('문제 4번')
print('-'*50)
print('userID  userName addr ')
print('-'*50)

curs.execute("""select distinct ut.userID, ut.userName, ut.addr
from buy_table bt 
	inner join user_table ut on bt.userID = ut.userID
order by ut.userID""")
rows = curs.fetchall()
print_by_rows(rows)

print('문제 5번')
print('-'*50)
print('userID  userName addr   연락처')
print('-'*50)

curs.execute("""select ut.userID, ut.userName, ut.addr, concat(mobile1, mobile2) "연락처"
from user_table ut
	inner join buy_table bt on bt.userID = ut.userID 
where addr in ('경북', '경남')""")
rows = curs.fetchall()
print_by_rows(rows)

# 연결 종료
curs.close()
conn.close()  # 데이터베이스 연결 종료
print('Database 연결 종료')
