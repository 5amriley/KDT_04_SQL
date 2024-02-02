import pymysql
import pandas as pd

# MySQL에 연결
conn = pymysql.connect(host='localhost', user='root',
                       password='2018',
                       db = 'sakila', charset='utf8')
# cursor 객체 생성
cur = conn.cursor()
cur.execute('select * from language')
rows = cur.fetchall()   # 모든 데이터를 가져옴
print(rows)
language_df = pd.DataFrame(rows)
print(language_df)

cur.close()
conn.close()    # 데이터베이스 연결 종료
