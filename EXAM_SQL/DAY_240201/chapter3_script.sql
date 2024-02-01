use sakila;

desc language;


# 필요에 따라 원래 language 테이블에 없는 컬럼을 즉석에서 만들어서 쓸 수 있다.
# language_usage 라는 이름의 열 : 'COMMON' 문자열로 이루어짐
# lang_pi_value 라는 이름의 열 : language_id 각각의 값에 3.14가 곱해진 값
# langue_name 라는 이름의 열 : name 각각의 값에 mysql 내장함수 upper()를 적용한 값
select language_id,
	'COMMON' language_usage,
	language_id * 3.14 lang_pi_value,
	upper(name) language_name
from language;


# 열의 별칭 : AS (가독성 향상)
select language_id,
	'COMMON' as language_usage,
	language_id * 3.14 as lang_pi_value,
	upper(name) as language_name
from language;

select actor_id from film_actor order by actor_id;


# 중복 제거 : distinct
select distinct actor_id from film_actor order by actor_id;


# subquery (파생 테이블)
# cust : 서브 쿼리의 별칭 (파생 테이블 이름)
select concat(cust.last_name, ', ', cust.first_name) full_name
from (
	select first_name, last_name, email from customer
	where first_name = 'JESSIE') as cust;


# temporary table (임시 테이블) : 데이터베이스 세션이 닫힐 때 사라짐
create temporary table actors_j
	(actor_id smallint(5),
	first_name varchar(45),
	last_name varchar(45));

desc actors_j;

insert into actors_j
	select actor_id, first_name, last_name
	from actor where last_name like 'J%';

select * from actors_j;


# view (가상 테이블)
# 실제 데이터가 저장되는 것이 아닌, view를 통해 데이터를 관리
# 복잡한 쿼리문을 매번 사용하지 않고, 가상테이블로 만들어서 쉽게 접근함
create view cust_vw as
	select customer_id, first_name, last_name, active from customer;

select * from cust_vw;

select first_name, last_name from cust_vw where active = 0;


# 가상 테이블 삭제
drop view cust_vw;


# 테이블 연결 : JOIN
# 연결 조건 : ON
# 두 개 이상의 테이블을 묶어서 하나의 결과 집합을 만들어 내는 것
# 내장함수 time() : datetime 데이터에서 시간 정보만 반환
# 내장함수 date() : datetime 데이터에서 날짜 정보만 반환
select customer.first_name, customer.last_name, time(rental.rental_date) as rental_time
from customer inner join rental on customer.customer_id = rental.customer_id 
where date(rental.rental_date) = '2005-06-14';

# AS 키워드 사용 ver.
select c.first_name, c.last_name, time(r.rental_date) as rental_time
from customer as c inner join rental as r on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14';


# where 절 연습
select title 
from film 
where rating='G' and rental_duration >= 7;

select title, rating, rental_duration
from film
where (rating='G' and rental_duration >= 7)
	or (rating='PG-13' and rental_duration < 4);


# 그룹화 : GROUP BY
# 그룹화 이후에 수행되는 조건 : HAVING
# 그룹화 이전 필터링 조건 : WHERE
select c.first_name, c.last_name, count(*) as rental_count
from customer as c inner join rental as r on c.customer_id = r.customer_id
group by c.first_name, c.last_name 
having count(*) >= 40
order by count(*) desc;


# 정렬 : ORDER BY
# 지정된 컬럼(열)을 기준으로 결과를 정렬 (다중 컬럼인 경우, 왼쪽부터 정렬)
select c.first_name, c.last_name, time(r.rental_date) as rental_time
from customer as c inner join rental as r on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14'
order by c.last_name, c.first_name asc;


# 실습 3-1 #
# actor 테이블에서 모든 배우의 actor_id, first_name, last_name을 검색하고
# last_name, first_name 을 기준으로 오름차순 정렬
select actor_id, first_name, last_name
from actor
order by last_name, first_name;


# 실습 3-2 #
# 성이 'WILLIAMS' 또는 'DAVIS' 인 모든 배우의 actor_id, first_name, last_name 을 검색
select actor_id, first_name, last_name
from actor 
where last_name = 'WILLIAMS' or last_name = 'DAVIS';


# 실습 3-3 #
# rental 테이블에서 2005년 7월 5일 영화를 대여한 고객 ID를 반환하는 쿼리를 작성하고, 
# date() 함수로 시간 요소를 무시 (년, 월, 일만 고려)
select distinct customer_id
from rental
where date(rental_date) = '2005-07-05';


# 실습 3-4 #
select c.store_id, c.email, r.rental_date, r.return_date
from customer as c inner join rental as r on c.customer_id = r.customer_id 
where date(r.rental_date) = '2005-06-14'
order by return_date desc;
