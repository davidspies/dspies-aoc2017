from collections import Counter
import re


linepattern = re.compile('''([a-z]*) \(([0-9]+)\)(?: -> ((?:[a-z]*, )*(?:[a-z]*)))?''')


def solution1(s):
    present = set()
    exclude = set()

    for line in s.strip().split('\n'):
        m = linepattern.match(line)
        base = m.group(1)
        present.add(base)
        g = m.group(3)
        if g:
            children = g.split(', ')
            exclude.update(children)

    return next(iter(present - exclude))


class Node(object):

    def __init__(self, name, weight, child_names):
        self.name = name
        self.weight = weight
        self.child_names = child_names

    def determine_children(self, node_map):
        self.children = [node_map[c] for c in self.child_names]

    def fix_of_bad_weight(self):
        for child in self.children:
            res = child.fix_of_bad_weight()
            if res is not None:
                return res
        self.total_weight = self.weight + sum(child.total_weight for child in self.children)
        weight_counts = Counter(child.total_weight for child in self.children)
        if len(weight_counts.keys()) > 1:
            bad_weight = min(weight_counts.keys(), key=lambda k: weight_counts[k])
            good_weight = max(weight_counts.keys(), key=lambda k: weight_counts[k])
            for c in self.children:
                if c.total_weight == bad_weight:
                    return good_weight - sum(x.total_weight for x in c.children)


def solution2(s):
    node_map = {}
    for line in s.strip().split('\n'):
        m = linepattern.match(line)
        name = m.group(1)
        weight = int(m.group(2))
        g = m.group(3)
        child_names = g.split(', ') if g else []
        node_map[name] = Node(name, weight, child_names)
    for v in node_map.values():
        v.determine_children(node_map)
    for v in node_map.values():
        fixed_weight = v.fix_of_bad_weight()
        if fixed_weight is not None:
            return fixed_weight
