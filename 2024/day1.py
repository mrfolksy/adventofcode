left = []
right = []

with open("./data/day1.txt") as f:
    for line in f:
        [l, r] = line.split("   ")
        left.append(int(l))
        right.append(int(r))

left.sort()
right.sort()


def part1():
    result = sum(abs(l - r) for l, r in zip(left, right))
    print(result)


def part2():
    grouped = {}
    for i in right:
        grouped[i] = grouped.get(i, 0) + 1

    result = sum(n * grouped.get(n, 0) for n in left)
    print(result)


part1()
part2()
