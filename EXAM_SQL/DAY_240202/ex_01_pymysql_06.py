import pymysql

# MySQL에 연결
conn = pymysql.connect(host='localhost', user='root',
                       password='2018',
                       db='sqlclass_db', charset='utf8')
# cursor 객체 생성
curs = conn.cursor()

sql = """update customer2
        set region = '서울특별시'
        where region = '서울'"""
curs.execute(sql)
print('update 완료')

sql = "delete from customer2 where name=%s"
curs.execute(sql, '홍길동')
print('delete 홍길동 완료')

conn.commit()
print('UPDATE, DELETE 완료')

# 연결 종료
curs.close()
conn.close()  # 데이터베이스 연결 종료
print('Database 연결 종료')
