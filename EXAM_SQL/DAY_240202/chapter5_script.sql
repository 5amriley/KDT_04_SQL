/*
 * 챕터 5
 */

use sakila;

# 내부 조인 (inner join)
select c.first_name, c.last_name, a.address
from customer as c inner join address as a 
on c.address_id = a.address_id ;


# join 이전 문법 (join 조건과 필터 조건을 구분하기 어려움)
select c.first_name, c.last_name, a.address
from customer as c join address as a 
where c.address_id = a.address_id and a.postal_code = 52137;

# 현재 표준 문법 표기 (SQL92)
select c.first_name, c.last_name, a.address
from customer as c join address as a 
	on c.address_id = a.address_id
where a.postal_code = 52137;


# 세 개 이상의 테이블 조인
# join 과정에서 from 절에 테이블의 순서는 중요하지 않음 (데이터베이스 내부에서 결정)
select c.first_name, c.last_name, ct.city, a.address, a.district, a.postal_code
from customer as c
	inner join address as a on c.address_id = a.address_id 
	inner join city as ct on a.city_id = ct.city_id ;


# 세 개 이상의 테이블 조인
# 서브 쿼리 사용
select c.first_name, c.last_name, addr.address, addr.city, addr.district
from customer as c
	inner join (
		select a.address_id, a.address, ct.city, a.district
		from address as a
			inner join city as ct 
			on a.city_id = ct.city_id
		where a.district = 'California'
		) as addr
on c.address_id = addr.address_id;


# 세 개 이상의 테이블 조인
# 테이블 재사용 (1)
select f.title, a.first_name, a.last_name
from film as f
	inner join film_actor as fa on f.film_id = fa.film_id 
	inner join actor a on fa.actor_id = a.actor_id 
where ((a.first_name = 'Cate' and a.last_name = 'MCQUEEN') 
		or (a.first_name = 'CUBA' and a.last_name = 'BIRCH'));

# 테이블 재사용 (2)
select f.title, a1.first_name, a2.first_name 
from film as f
	# film, film_actor, actor 내부 조인 #1
	inner join film_actor as fa1 on f.film_id = fa1.film_id 
	inner join actor a1 on fa1.actor_id = a1.actor_id 
	# film, film_actor, actor 내부 조인 #2
	inner join film_actor as fa2 on f.film_id = fa2.film_id 
	inner join actor a2 on fa2.actor_id = a2.actor_id 
where (a1.first_name = 'CATE' and a1.last_name = 'MCQUEEN')
	and (a2.first_name = 'CUBA' and a2.last_name = 'BIRCH');


# 셀프 조인 (self join)
use sqlclass_db;

# 테이블 생성
create table customer (
	customer_id smallint unsigned,
	first_name varchar(20),
	last_name varchar(20),
	birth_date date,
	spouse_id smallint unsigned,
	constraint primary key (customer_id)
	);
desc customer;

# 테이블에 데이터 추가
insert into customer (customer_id, first_name, last_name, birth_date, spouse_id)
values 
	(1, 'John', 'Mayer', '1983-05-12', 2),
	(2, 'Mary', 'Mayer', '1990-07-30', 1),
	(3, 'Lisa', 'Ross', '1989-04-15', 5),
	(4, 'Anna', 'Timothy', '1988-12-26', 6),
	(5, 'Tim', 'Ross', '1957-08-15', 3),
	(6, 'Steve', 'Donell', '1967-07-09', 4);

insert into customer (customer_id, first_name, last_name, birth_date)
values (7, 'Donna', 'Trapp', '1978-06-23');

select * from customer;

# 셀프 조인 (self join) 실행
select
	cust.customer_id,
	cust.first_name,
	cust.last_name,
	cust.birth_date,
	cust.spouse_id,
	spouse.first_name as spouse_firstname,
	spouse.last_name as spouse_lastname
from customer as cust
	join customer as spouse 
		on cust.spouse_id = spouse.customer_id;


# 셀프 조인 예시 2
use sakila;
	
select a1.address as addr1, a2.address as addr2, a1.city_id, a1.district
from address as a1
	inner join address as a2
where (a1.city_id = a2.city_id) and (a1.address_id != a2.address_id);
