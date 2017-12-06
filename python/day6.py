def solution1(s):
    banks = list(map(int, s.strip().split()))
    seen = set()
    count = 0
    while tuple(banks) not in seen:
        seen.add(tuple(banks))
        distind = max(range(len(banks)), key=lambda i: banks[i])
        v = banks[distind]
        banks[distind] = 0
        for i in range(distind + 1, distind + 1 + v):
            banks[i % len(banks)] += 1
        count += 1
    return count

def solution2(s):
    banks = list(map(int, s.strip().split()))
    seen = set()
    while tuple(banks) not in seen:
        seen.add(tuple(banks))
        distind = max(range(len(banks)), key=lambda i: banks[i])
        v = banks[distind]
        banks[distind] = 0
        for i in range(distind + 1, distind + 1 + v):
            banks[i % len(banks)] += 1
    count = 0
    seenagain = set()
    while tuple(banks) not in seenagain:
        seenagain.add(tuple(banks))
        distind = max(range(len(banks)), key=lambda i: banks[i])
        v = banks[distind]
        banks[distind] = 0
        for i in range(distind + 1, distind + 1 + v):
            banks[i % len(banks)] += 1
        count += 1
    return count
