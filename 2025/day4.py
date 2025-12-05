input = []
with open("data/day4.txt") as f:
    while l := f.readline():
        input.append(list(l.strip()))


def can_remove_roll(data, i, j):
    count = 0

    xr = range(max(0, i - 1), min(len(data), i + 2))
    yr = range(max(0, j - 1), min(len(data), j + 2))
    for x in xr:
        for y in yr:
            if x == i and y == j:
                continue
            count += 1 if data[x][y] == "@" else 0

    return count < 4


def part1(input):
    res = 0
    for i in range(len(input[0])):
        for j in range(len(input[i])):
            if input[i][j] == "@" and can_remove_roll(input, i, j):
                res += 1
    return res


def part2(input):
    res = 0

    data = input
    while True:
        rolls_taken = []
        for i in range(len(data[0])):
            for j in range(len(data[i])):
                if data[i][j] == "@" and can_remove_roll(data, i, j):
                    rolls_taken.append((i, j))

        if len(rolls_taken) == 0:
            break

        else:
            res += len(rolls_taken)
            for r in rolls_taken:
                data[r[0]][r[1]] = "x"

    return res


print(f"Part 1 - {part1(input)}")
print(f"Part 2 - {part2(input)}")
