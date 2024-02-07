def calc(values):
    sum = None
    try:
        print(values)
        sum = values[0] + values[1] + values[2]
        print('try 문의 끝')
    except IndexError as err:
        # IndexError 라면, 이 구문이 실행된 후 finally 로 넘어간다.
        print('인덱스 에러: ', err)
    except Exception as err:
        print(err)
    else:
        # try 문에서 예외가 발생하지 않을 경우에만 실행
        print('에러 없음')
    finally:
        # 예외 발생여부와 상관없이 실행
        print(f'sum={sum}')


calc([1, 2, 3])
calc([1, 2])
