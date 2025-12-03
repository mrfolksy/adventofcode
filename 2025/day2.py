with open("data/day2.txt") as f:
    data = f.read().strip().split(",")


def product_ids(s: str):
    [start, end] = s.split("-")
    return range(int(start), int(end) + 1)


def part1(id):
    _id = str(id)

    mid = int(len(_id) / 2)
    first, second = _id[0:mid], _id[mid:]

    return id if first == second else 0


def part2(id):
    _id = str(id)

    def split_string(s, n):
        return [s[i : i + n] for i in range(0, len(s), n)]

    mid = int(len(_id) / 2)
    for n in range(1, mid + 1):
        parts = split_string(_id, n)
        if len(parts) > 1 and len(set(parts)) == 1:
            return id

    return 0


def run(func):
    sum = 0
    for range in data:
        for id in product_ids(range):
            sum += func(id)

    return sum


print(f"Part 1 - {run(part1)}")
print(f"Part 2 - {run(part2)}")
