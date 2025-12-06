input = []
with open("data/day6.txt") as f:
    while l := f.readline():
        input.append(l)


def part1():
    data = [l.strip().split() for l in input]

    res = 0
    rows = len(data)
    cols = len(data[0])

    for c in range(cols):
        exp = data[-1][c].join([data[v][c] for v in range(rows - 1)])
        res += eval(exp)

    return res


def part2():
    # get indexes for ops in the last row
    ops = []
    for i in range(len(input[-1])):
        c = input[-1][i]
        if c == "+" or c == "*":
            ops.append(i)

    res = 0
    for i, v in enumerate(ops):
        # A segment (sg) is a vertical slice with the width up to the next segment
        # <-sg-><-sg->
        # |....|.....|
        # |+...|*....|
        if i < len(ops) - 1:
            sg = (v, ops[i + 1] - 1)
        else:
            sg = (v, len(input[-1]) - 1)

        # Calculate value from segment
        op = input[-1][sg[0]]
        nums = []
        for c in range(sg[1], sg[0] - 1, -1):

            num = ""
            for r in input[0:-1]:
                num += r[c]

            if num.strip() != "":
                nums.append(num.strip())

        res += eval(op.join(nums))

    return res


print(part2())
