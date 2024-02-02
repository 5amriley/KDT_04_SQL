import pymysql

def create_table(conn, cur):
    """ 테이블 생성 함수 """
    try:
        query = """
                create table customer2 (
                name varchar(10),
                category smallint,
                region varchar(10));
        """

        cur.execute(query)
        conn.commit()
        print('테이블 생성 완료')
    except Exception as e:
        print(e)


def main():
    # MySQL에 연결
    conn = pymysql.connect(host='localhost', user='root',
                           password='2018',
                           db='sqlclass_db', charset='utf8')
    # cursor 객체 생성
    cur = conn.cursor()

    # 테이블 생성 함수 호출
    create_table(conn, cur)

    # 연결 종료
    cur.close()
    conn.close()  # 데이터베이스 연결 종료
    print('Database 연결 종료')


main()
