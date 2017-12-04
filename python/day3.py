import collections
import itertools


def incr_diff(d):
    return {'N':(0,1),'E':(1,0),'S':(0,-1),'W':(-1,0)}[d]


class Turtle(object):

    def __init__(self, position, heading):
        self.position = position
        self.heading = heading

    def fd1(self):
        (x,y) = self.position
        (xd,yd) = incr_diff(self.heading)
        self.position = (x+xd,y+yd)

    def lt90(self):
        self.heading = {'N':'W','E':'N','S':'E','W':'S'}[self.heading]


def spiral():
    t = Turtle(position=(0,0), heading='E')
    yield t.position
    for n in itertools.count(2,2):
        t.fd1()
        yield t.position
        t.lt90()
        for _ in range(n-1):
            t.fd1()
            yield t.position
        for _ in range(3):
            t.lt90()
            for _ in range(n):
                t.fd1()
                yield t.position


def solution1(s):
    sp = spiral()
    for _ in range(int(s)):
        (x,y) = next(sp)
    return abs(x) + abs(y)


def adjacent(p):
    (x,y) = p
    for dx in range(-1,2):
        for dy in range(-1,2):
            yield (x+dx,y+dy)


def surround_sums():
    totals = collections.defaultdict(int,{(0,0):1})
    for p in spiral():
        totals[p] = sum(totals[pn] for pn in adjacent(p))
        yield totals[p]


def solution2(s):
    n = int(s)
    for ss in surround_sums():
        if ss > n:
            return ss
