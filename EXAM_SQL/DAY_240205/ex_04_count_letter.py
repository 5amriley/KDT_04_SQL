filename = input('파일명을 입력하세요: ').strip()
infile = open(filename, 'r')

freqs = {}  # 딕셔너리 생성

# 파일의 각 줄에서 문자를 추출한 다음, 각 문자를 dict에 추가
for line in infile:
    print(line)
    for char in line.strip():
        if char in freqs:
            freqs[char] += 1    # 딕셔너리에 key(char)가 있으면 증가
        else:
            freqs[char] = 1     # 딕셔너리에 key(char)가 없으면 추가

print(freqs)
infile.close()
