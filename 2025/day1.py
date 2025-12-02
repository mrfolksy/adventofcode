from operator import add, sub

filename = "day1.txt"


data = []
with open(f"./data/{filename}") as f:
    data = f.readlines()


def update_val(curr: int, line: str) -> tuple[int, int]:
    instr, val, rotations = line[0], int(line[1:-1]), 0

    # playing with passing functions around.
    # If L then use subtration (sub) otherwise use add (addition)
    func = sub if instr == "L" else add
    steps, direction = func(curr, val), func(0, 1)

    new_val = steps % 100
    for x in range(curr, steps, direction):
        if x % 100 == 0:
            rotations += 1

    return new_val, rotations


def part1():
    result, value = 0, 50

    for instr in data:
        value, _ = update_val(value, instr)
        if value == 0:
            result += 1

    return result


def part2():
    zero_count, value = 0, 50

    for instr in data:
        value, rotations = update_val(value, instr)
        zero_count += rotations
    return zero_count


print(f"Part 1: code is {part1()}")
print(f"Part 2: code is {part2()}")
