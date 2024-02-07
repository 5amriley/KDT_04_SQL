/*
 * 챕터 7
 */

# cast() : 지정한 값을 다른 데이터 타입으로 변환
select cast('2019-09-17 15:30:00' as datetime);

select cast('2019-09-17' as date) date_field,
		cast('108:17:57' as time) time_field; 


# str_to_date() : 날짜 생성 함수 (형식 문자열의 내용에 따라 datetime, date 또는 time 값을 반환)
# cast() 함수를 사용하기에 적절한 형식이 아닌 경우 사용한다.
select str_to_date('September 17, 2019', '%M %d, %Y') as return_date;


# 현재 날짜/시간 생성
# 내장 함수가 시스템 시계를 확인해서 현재 날짜 및 시간을 문자열로 반환
select current_date(), current_time(), current_timestamp();


# date_add() : 날짜를 반환하는 시간 함수 (지정한 날짜에 일정 기간을 더해서 다른 날짜를 생성)
select date_add(current_date(), interval 5 day);
select date_add(current_date(), interval '3:27:11' hour_second);


# last_day(date) : 해당 월의 마지막 날짜 반환
select last_day('2022-08-01');


# dayname(date) : 해당 날짜의 영어 요일 이름을 반환
select dayname('2022-08-01');


# extract() : date의 구성 요소 중 일부를 추출
select extract(year from '2019-09-18 22:19:05');


# datediff(date1, date2) : 두 날짜 사이의 기간(년, 주, 일)을 계산
# 시간 정보는 무시
select datediff('2019-09-03', '2019-06-21');
