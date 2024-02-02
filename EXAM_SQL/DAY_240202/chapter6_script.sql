/*
 *	챕터 6
 */

use sakila;

# union 연산자 (중복 제거 O)
select 1 as num, 'abc' as str
union
select 9 as num, 'xyz' as str;

# union all 연산자 (중복 제거 X)
select 'ACTR1' as type, a.first_name, a.last_name
from actor as a
union all
select 'ACTR2' as type, a.first_name, a.last_name 
from actor as a;


# intersect 연산자
# intersect ver.
select c.first_name, c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%'
intersect 
select a.first_name, a.last_name 
from actor a
where a.first_name like 'J%' and a.last_name like 'D%';

# inner join ver.
select c.first_name, c.last_name
from customer as c
	inner join actor as a 
		on (c.first_name = a.first_name) and (c.last_name = a.last_name)
where a.first_name like 'J%' and a.last_name like 'D%';

	
# except 연산자
select a.first_name, a.last_name
from actor a
where a.first_name like 'J%' and a.last_name like 'D%'
except
select c.first_name, c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%';


# 복합 쿼리는 위에서 아래의 순서대로 실행
# 예외 : intersect 연산자가 다른 집합 연산자보다 우선순위가 높음


# 실습 6-2 #
# actor와 customer 테이블에서 성이 L로 시작하는 사람의 이름과 성을 찾는 복합 쿼리 작성
select first_name, last_name
from actor 
where last_name like 'L%'
union 
select first_name, last_name 
from customer
where last_name like 'L%';


# 실습 6-3 #
# last_name 열을 기준으로 실습 6-2의 결과를 오름차순으로 정렬하시오.
select first_name, last_name
from actor
where last_name like 'L%'
union 
select first_name, last_name 
from customer 
where last_name like 'L%'
order by last_name;
