use sakila;

# 동등 조건 (equality condition) : '열 = 표현/값'
select c.email
from customer as c
	inner join rental as r 
	on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14';


# 부동 조건 (inequality condition) : 두 표현이 동일하지 않음
select c.email, r.rental_date
from customer as c
	inner join rental as r
	on c.customer_id = r.customer_id 
where date(r.rental_date) <> '2005-06-14';


# 범위 조건
# rental_date 컬럼은 datetime 속성으로, 날짜와 시간을 같이 포함
# rental_date <= '2005-06-16' 일 때 2005-06-16은 포함되지 않음 (시간 정보 때문)
# 2005-06-16 00:00:01 > '2005-06-16' 이라고 생각하기 때문
select customer_id, rental_date
from rental 
where rental_date <= '2005-06-16'
	and rental_date >= '2005-06-14';
	

# date(rental_date) 를 사용 : 정확한 날짜만 추출
# 2005-06-14 일부터 2005년 6월 16일까지의 데이터가 추출됨
select customer_id, rental_date
from rental 
where date(rental_date) <= '2005-06-16'
	and date(rental_date) >= '2005-06-14';


# between 연산자
# between [범위의 하한값] and [범위의 상한값]
select customer_id, rental_date
from rental 
where date(rental_date) between '2005-06-14' and '2005-06-16';

# between 왼쪽 : 하한값
# between 오른쪽 : 상한값
# 을 지키지 않을 경우 결과값이 나오지 않을 수 있다.
select customer_id, rental_date
from rental
where date(rental_date) between '2005-06-16' and '2005-06-14';

# between 숫자범위
select customer_id, payment_date, amount
from payment
where amount between 10.0 and 11.99;

# between 문자열 범위
select last_name, first_name
from customer 
where last_name between 'FA' and 'FRB';

# in 연산자
select title, rating
from film 
where rating in ('G', 'PG');

select title, rating
from film 
where rating='G' or rating='PG';


# 서브 쿼리 사용
# '%PET%' : PET을 포함하는 단어
select title, rating
from film 
where rating in (select rating from film where title like '%PET%');

select title, rating from film where title like '%PET%';


# not in 연산자
select title, rating
from film 
where rating not in ('PG-13', 'R', 'NC-17');

select title, rating
from film 
where rating = 'NC-17';


# 문자열 부분 가져오기
# 데이터베이스에서의 시작위치 : 1
select left('abcdefg', 3);
select mid('abcdefg', 2, 3);
select right('abcdefg', 2);

# [와일드 카드]
# '_' : 정확히 한 문자 (underscore)
# '%' : 개수에 상관없이 모든 문자 포함
# 와일드 카드 사용시 LIKE 연산자를 사용
select last_name, first_name
from customer 
where last_name like '_A_T%S';

select last_name, first_name 
from customer 
where last_name like 'Q%' or last_name like 'Y%';

# 정규식 / 정규표현식 : REGEXP
# Regular Expression
# '^[QY]' : Q 또는 Y 로 시작하는 단어 검색
select last_name, first_name
from customer 
where last_name regexp '^[QY]';


# Null 의 뜻 (in SQL)
# - 해당 사항 없음
# - 아직 알려지지 않은 값
# - 정의되지 않은 값

# is null 연산자
select rental_id, customer_id, return_date
from rental 
where return_date is null;

select rental_id, customer_id, return_date
from rental 
where return_date is not null;

select rental_id, customer_id, return_date
from rental 
where return_date is null 
	or date(return_date) not between '2005-05-01' and '2005-09-01';


# 서브셋 조건 설정
select payment_id, customer_id, amount, date(payment_date) as payment_date
from payment 
where (payment_id between 101 and 120);


# 실습 4-1 #
