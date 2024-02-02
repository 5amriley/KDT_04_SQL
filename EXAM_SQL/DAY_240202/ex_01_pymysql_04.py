import pymysql

# MySQL에 연결
conn = pymysql.connect(host='localhost', user='root',
                       password='2018',
                       db='sqlclass_db', charset='utf8')
# cursor 객체 생성
curs = conn.cursor()

sql = """insert into customer2 (name, category, region)
            values (%s, %s, %s)"""

curs.execute(sql, ('홍길동', 1, '서울'))
curs.execute(sql, ('이연수', 2, '서울'))

conn.commit()
print('INSERT 완료')

# 연결 종료
curs.close()
conn.close()  # 데이터베이스 연결 종료
print('Database 연결 종료')
