ranges = []
ids = []

with open("data/day5.txt") as f:
    for l in f.readlines():
        l = l.strip()

        if len(l) == 0:
            continue

        if "-" in l:
            parts = l.split("-")
            range = (int(parts[0]), int(parts[1]))
            ranges.append(range)
        else:
            ids.append(int(l))


def part1():
    res = 0
    for id in ids:
        for r in ranges:
            if r[0] <= id <= r[1]:
                res += 1
                break
    return res


def part2():
    _ranges = sorted(ranges, key=lambda r: r[0])
    merged = [_ranges[0]]

    for curr in _ranges[1:]:
        prev = merged[-1]

        # Case where there is a complete overlap
        # prev: <------------>
        # curr:     <---->
        # merg: <------------>
        if curr[0] >= prev[0] and curr[1] <= prev[1]:
            continue

        # Case where there is a partial overlap
        # prev: <------->
        # curr:     <-------->
        # merg: <------------>
        if (prev[0] <= curr[0] <= prev[1]) and curr[1] >= prev[1]:
            merged[-1] = (prev[0], curr[1])
            continue

        merged.append(curr)

    res = 0
    for r in merged:
        res += r[1] - r[0] + 1

    return res


print(f"Part 1: {part1()}")
print(f"Part 2: {part2()}")
