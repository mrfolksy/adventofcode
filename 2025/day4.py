data = []
with open("data/day4.txt") as f:
    while l := f.readline():
        data.append(l.strip())


def part1(data):
    def count_rolls(i, j):
        """
          -1
        -1 0 1
           1
        """
        count = 0

        xr = range(max(0, i - 1), min(len(data), i + 2))
        yr = range(max(0, j - 1), min(len(data), j + 2))
        for x in xr:
            for y in yr:
                if x == i and y == j:
                    continue
                count += 1 if data[x][y] == "@" else 0

        return count

    res = 0
    for i in range(len(data[0])):
        for j in range(len(data[i])):
            if data[i][j] == "@" and count_rolls(i, j) < 4:
                res += 1
    return res


print(f"Part 1 - {part1(data)}")
