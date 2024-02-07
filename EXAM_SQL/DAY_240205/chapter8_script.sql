/*
 * 챕터 8 [ 그룹화와 집계 ]
 */

use sakila;

# 가장 많이 대여한 회원 찾기
select customer_id, count(*)
from rental 
group by customer_id 
order by 2 desc;

select customer_id, count(*)
from rental 
group by customer_id 
order by count(*) desc;


# where 절에서는 group by 연산을 수행할 수 없음. 집계함수 count(*) 사용하지 못함
# 그룹 단위로 조건을 적용하려면 having 절에 group by 연산을 해야 한다.
select customer_id, count(*)
from rental 
#where count(*) > 40
group by customer_id
having count(*) > 40;


# 집계 함수 사용
select max(amount) as max_amt,
		min(amount) as min_amt,
		avg(amount) as avg_amt,
		sum(amount) as tot_amt,
		count(*) as num_payments
from payment;


# group by 문 없음, 그룹화하지 않은 일반 컬럼, 집계함수 혼용 => 에러 발생
select customer_id,
		max(amount) as max_amt,
		min(amount) as min_amt,
		avg(amount) as avg_amt,
		sum(amount) as tot_amt,
		count(*) as num_pyaments
from payment
group by customer_id ;   # 이거 없으면 에러 발생


# 다중 열 그룹화 (중요!) ~ 이중 그룹화 (id, rating 까지 같은 것 끼리)
select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f 
	on fa.film_id = f.film_id 
group by fa.actor_id, f.rating 
order by 1, 2;


# 표현식으로 생성한 값을 기반으로 그룹 생성하기
select extract(year from rental_date) as year,
		count(*) as how_many
from rental 
group by extract(year from rental_date);


# 롤업 생성 (group by 결과로 출력된 항목들의 합계를 나타내는 방법)
select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id 
group by fa.actor_id, f.rating  with rollup
order by 1, 2;


# where : 전체 단위의 필터링
# having : 그룹 단위의 필터링 (그룹 연산)
select fa.actor_id, f.rating, count(*)
from film_actor fa 
	inner join film f 
		on fa.film_id = f.film_id 
where f.rating in ('G', 'PG')
group by fa.actor_id, f.rating 
having count(*) > 9
order by 3 desc;

