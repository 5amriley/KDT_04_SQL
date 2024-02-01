'''
2024/01/31 과제 2
딕셔너리 생성 및 정렬 프로그램
아래에 주어진 총 6개 나라의 수도에 대한 국가명, 대륙, 인구수를 표시한 테이블을 이용하여 딕셔너리를 작성하고,
아래 실행 화면과 같이 출력을 하는 프로그램을 작성하시오.
[기능 구현 내용]
1. 전체 데이터 출력
    - 위의 테이블을 이용하여 dictionary를 생성하고 전체 데이터를 화면에 출력
    - Key: 수도 이름, value: 국가명, 대륙, 인구수
2. 수도 이름 오름차순 출력
    - 수도 이름을 기준으로 오름차순 정렬한 다음 수도이름, 인구수만 화면에 출력
    - 자리 수 맞춤
3. 모든 도시의 인구수 내림차순 출력
    - 인구수를 내림차순으로 정렬한 다음 수도이름, 인구수만 화면에 출력
    - 자리 수 맞춤
4. 특정 도시의 정보 출력
    - 화면에서 입력받은 수도 이름이 딕셔너리의 key에 존재하면, 해당 수도의 모든 정보를 화면에 출력함
    - 수도 이름이 딕셔너리에 존재하지 않으면, "도시이름:XXX은 key에 없습니다."를 출력
5. 대륙별 인구수 계산 및 출력
    - 화면에서 대륙 이름을 입력받고 해당 대륙에 속한 국가들의 인구수를 출력하고 전체 인구수의 합을 계산하여 출력
    - 잘못된 대륙 이름 검사는 없음
6. 프로그램 종료
'''


def print_menu():
    """ 전체 메뉴 출력 """
    print('-' * 30)
    print('1. 전체 데이터 출력')
    print('2. 수도 이름 오름차순 출력')
    print('3. 모든 도시의 인구수 내림차순 출력')
    print('4. 특정 도시의 정보 출력')
    print('5. 대륙별 인구수 계산 및 출력')
    print('6. 프로그램 종료')
    print('-' * 30)


def print_capital_dict(dict_x):
    """ 전체 데이터 출력 """
    idx = 1
    for key, value in dict_x.items():
        print(f'[{idx}] {key}: {value}')
        idx += 1


def print_capital_sorted(dict_x):
    """ 수도 이름 오름차순 출력 """
    a = list(dict_x.keys())
    idx = 1
    for k in sorted(a):
        print(f'[{idx}] {k:<12s} : {dict_x[k][0]:<15s} {dict_x[k][1]:<12s} {dict_x[k][2]:,}')
        idx += 1


def print_population_reverse1(dict_x):
    """ 모든 도시의 인구수 내림차순 출력 """
    capi_list = []
    popul_list = []
    for key, value in dict_x.items():
        capi_list.append(key)
        popul_list.append(value[2])

    # 이 알고리즘의 핵심 #
    index_order = [0] * len(dict_x)
    sorted_popul_list = sorted(popul_list, reverse=True)
    for i, n in enumerate(popul_list):
        order = sorted_popul_list.index(n)
        index_order[order] = i

    idx = 1
    for i in index_order:
        print(f'[{idx}] {capi_list[i]:12s} {popul_list[i]:,}')
        idx += 1


def print_population_reverse2(dict_x):
    """ 모든 도시의 인구수 내림차순 출력 """
    # 인구수를 키로 가지는 새로운 딕셔너리 생성 #
    population_key_dict = dict()
    for key, value in dict_x.items():
        population_key_dict[value[2]] = key

    sorted_popul_list = sorted(population_key_dict.keys(), reverse=True)
    idx = 1
    for popul in sorted_popul_list:
        print(f'[{idx}] {population_key_dict[popul]:12s} {popul:,}')
        idx += 1


def conditional_print(dict_x):
    """ 특정 도시의 정보 출력 """
    capi = input('출력할 도시 이름을 입력하세요: ')

    if capi in dict_x:
        print(f'도시: {capi}')
        print(f'국가: {dict_x[capi][0]}, 대륙: {dict_x[capi][1]}, 인구수: {dict_x[capi][2]:,}')
    else:
        print(f'도시이름: {capi}는 key에 없습니다.')


def print_continent_sum(dict_x):
    """ 대륙별 인구수 계산 및 출력 """
    conti = input('대륙 이름을 입력하세요(Asia, Europe, America): ')
    total_population = 0

    for k , v in dict_x.items():
        if v[1] == conti:
            total_population += v[2]

    print(f'{conti} 전체 인구수: {total_population:,}')


capital_dict = {
    'Seoul':['South Korea', 'Asia', 9655000],
    'Tokyo':['Japan', 'Asia', 14110000],
    'Beijing':['China', 'Asia', 21540000],
    'London':['United Kingdom', 'Europe', 14800000],
    'Berlin':['Germany', 'Europe', 3426000],
    'Mexico City':['Mexico', 'America', 21200000],
}


menu = 0
while menu != 6:
    print_menu()
    menu = int(input("메뉴를 입력하세요: "))
    if menu == 1:
        # 1. 전체 데이터 출력
        print_capital_dict(capital_dict)
    elif menu == 2:
        # 2. 수도 이름 오름차순 출력
        print_capital_sorted(capital_dict)
    elif menu == 3:
        # 3. 모든 도시의 인구수 내림차순 출력
        print_population_reverse1(capital_dict)
    elif menu == 4:
        # 4. 특정 도시의 정보 출력
        conditional_print(capital_dict)
    elif menu == 5:
        # 5. 대륙별 인구수 계산 및 출력
        print_continent_sum(capital_dict)
    elif menu == 6:
        # 6. 프로그램 종료
        print('프로그램을 종료합니다.')
        break
