/*
 * 챕터 7
*/

use testdb;

# 테이블 생성
create table string_tbl(
	char_fld char(30),
	vchar_fld varchar(30),
	text_fld text
	);

desc string_tbl;

# 문자열 데이터를 테이블에 추가
insert into string_tbl (char_fld, vchar_fld, text_fld)
values ('This is char data',
		'This is varchar data',
		'This is text data');

# 저장된 내용 확인
select * from string_tbl;

update string_tbl 
set vchar_fld = 'This is a piece of extremely long varchar data';


# GUI 상에서 string_tbl 테이블의 vchar_tbl 속성값 변경이 가능하다.
# 왼쪽 Database Navigator 에서 해당 테이블의 속성을 더블클릭 ->
# Data Type 변경 -> ALTER ~ 문 적용할 지 확인 -> Persist


# 현재 모드 확인
select @@session.sql_mode;

# ANSI 모드 선택 (권장하지 않음)
#set sql_mode = 'ansi';


# escape 문자 추가 방법
# 1. 작은 따옴표를 하나 더 추가
update string_tbl 
set text_fld = 'This string didnt''t work, but it does now';

# 2. 백슬래시('\') 문자 추가
update string_tbl 
set text_fld = 'This string didn\'t work, but it does now';

# 3. quote() 내장함수
# 전체 문자열을 따옴표로 묶고, 문자열 내부의 작은 따옴표에 escape 문자를 추가
select quote(text_fld)
from string_tbl;

# quote() 안 썼을 때와 비교
select text_fld from string_tbl;


# length() 내장함수
# char 타입은 빈 공간을 공백으로 채우지만, length를 조회할 때 공백은 제외된다.
select length(char_fld) as char_length,
	length(vchar_fld) as varchar_length,
	length(text_fld) as text_length
from string_tbl;


# position() 내장함수
# 부분 문자열의 위치를 반환, 첫 인덱스(1)부터 찾는다.
# 부분 문자열을 찾을 수 없는 경우, 
select position('data' in vchar_fld)
from string_tbl;

# locate('문자열', 열이름, 시작위치) 내장함수
# 시작위치(지정가능)부터 문자열 검색, 처음 발견되는 인덱스 리턴
select locate('is', vchar_fld, 5)
from string_tbl;

select locate('is', vchar_fld, 1)
from string_tbl;

# strcmp() 내장함수
# strcmp('문자열1', '문자열2')
# 문자열1 < 문자열2 라면, -1 반환
# 문자열1 == 문자열2 라면, 0 반환
# 문자열1 > 문자열2 라면, 1 반환
# MySQL 은 대소문자 구분 안 함

# 테이블의 자료만 삭제 : DELETE
delete from string_tbl ;

insert into string_tbl (vchar_fld)
values ('abcd'), 
		('xyz'), 
		('QRSTUV'),
		('qrstuv'), 
		('12345');

select vchar_fld from string_tbl order by vchar_fld;

select strcmp('12345', '12345') 12345_12345,
		strcmp('abcd', 'xyz') abcd_xyz,
		strcmp('abcd', 'QRSTUV') qrstuv_QRSTUV,
		strcmp('text', 'text2');


# like 또는 regexp 연산자 사용
use sakila;

# like ver.
select name, name like '%y' ends_in_y
from category;

# regexp ver.
select name, name regexp 'y$' ends_in_y
from category;


# concat() 내장함수 : 문자열 추가함수
# 예제 1
use testdb;

delete from string_tbl;

insert into string_tbl (text_fld)
values ('This string was 29 characters');

update string_tbl 
set text_fld = concat(text_fld, ', but now it is longer');

select text_fld from string_tbl;

# 예제 2
use sakila;

select concat(first_name, ' ', last_name, 
			' has been a customer since ', date(create_date)) as cust_narrative
from customer;


# insert() 내장함수
# insert(원본문자열, 시작위치, 길이, 새로운 문자열)
# 세 번째 인수값(길이)=0 : 새로운 문자열이 삽입
select insert('goodbye world', 9, 0, 'cruel ') as string;

# 세 번째 인수값 > 0 : 해당 문자열로 대치
# 인덱스 1부터 7까지의 내용이 삭제되고 'hello'가 삽입
select insert('goodbye world', 1, 7, 'hello') as string;


# replace() 내장함수
# replace(문자열, 기존문자열, 새문자열)
# 기존 문자열을 찾아서 제거하고, 새로운 문자열을 삽입
select replace('goodbye world', 'goodbye', 'hello') as replace_str;

# substr(), substring() 내장함수
# substr(문자열, 시작위치, 개수)
# 문자열에서 시작 위치에서 개수만큼 추출
select substr('goodbye cruel world', 9, 5);
