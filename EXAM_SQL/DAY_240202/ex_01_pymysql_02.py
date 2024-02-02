import pymysql
import pandas as pd

# MySQL에 연결
conn = pymysql.connect(host='localhost', user='root',
                       password='2018',
                       db = 'sakila', charset='utf8')
# cursor 객체 생성
cur = conn.cursor()
query = """
select c.email
from customer as c 
    inner join rental as r
        on c.customer_id = r.customer_id
where date(r.rental_date) = (%s)"""
cur.execute(query, ('2005-06-14'))
rows = cur.fetchall()   # 모든 데이터를 가져옴
for row in rows:
    print(row)

cur.close()
conn.close()    # 데이터베이스 연결 종료
