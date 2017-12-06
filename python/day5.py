def solution2(s):
    xs = list(map(int, s.strip().split('\n')))
    i = 0
    count = 0
    while i >= 0 and i < len(xs):
        jump = xs[i]
        xs[i] = jump - 1 if jump >= 3 else jump + 1
        i += jump
        count += 1
    return count
