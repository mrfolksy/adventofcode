from typing import Literal
from copy import deepcopy

"""
    N
  W   E 
    S
"""
Direction = Literal["N", "E", "S", "W"]

# The gaurd always starts facing north
INIT_DIR = "N"


def initialise_map():
    with open("./data/day6.txt") as f:
        input = f.read().split("\n")

    map = []
    for line in input:
        map.append([c for c in line])

    return map


def print_map(map):
    for row in map:
        print("".join(row))


def start_loc(map) -> tuple[int, int]:
    for i in range(0, len(map)):
        for j in range(0, len(map[0])):
            if map[i][j] == "^":
                return (i, j)
    return (0, 0)


def is_inmap(map, loc: tuple) -> bool:
    return loc[0] >= 0 and loc[0] < len(map) and loc[1] >= 0 and loc[1] < len(map[0])


def visit(map, loc: tuple) -> bool:
    if map[loc[0]][loc[1]] == "X":
        return 0
    map[loc[0]][loc[1]] = "X"
    return 1


def step(loc, dir: Direction):
    if dir == "N":
        return (loc[0] - 1, loc[1])
    if dir == "E":
        return (loc[0], loc[1] + 1)
    if dir == "S":
        return (loc[0] + 1, loc[1])
    if dir == "W":
        return (loc[0], loc[1] - 1)


def turn(dir: Direction) -> Direction:
    if dir == "N":
        return "E"
    if dir == "E":
        return "S"
    if dir == "S":
        return "W"
    if dir == "W":
        return "N"


def lookahead(map, loc: tuple, dir: Direction):
    next_loc = step(loc, dir)
    if not is_inmap(map, next_loc):
        return None

    return map[next_loc[0]][next_loc[1]]


def has_looped(start_loc, loc: tuple, dir: Direction):
    if start_loc == loc and dir == INIT_DIR:
        return True


def sum_visited_locations(map):
    count = 0
    for row in map:
        for cell in row:
            if cell == "X":
                count += 1
    return count


def patrol(map, guard_loc: tuple, start_dir: Direction):
    loc = guard_loc
    facing = start_dir
    seen_new_block = False

    while True:
        ahead = lookahead(map, loc, facing)

        if ahead == "O" and seen_new_block:
            return True

        if ahead == "#" or ahead == "O":
            facing = turn(facing)
        else:
            next_loc = step(loc, facing)
            if is_inmap(map, next_loc):
                visit(map, loc)
                loc = next_loc
            else:
                visit(map, loc)
                break

        if has_looped(guard_loc, loc, facing):
            return True

        if ahead == "O" and not seen_new_block:
            seen_new_block = True

    return False


def part1(map):
    patrol(map, start_loc(map), INIT_DIR)
    return sum_visited_locations(map)


def part2(map):
    count = 0
    patrol_count = 0
    guard_loc = start_loc(map)

    for i in range(0, len(map)):
        for j in range(0, len(map[0])):
            if map[i][j] == ".":
                map[i][j] = "O"

                if patrol_count == 427:
                    print_map(map)
                    print(f"{i} {j}")

                looped = patrol(map, guard_loc, INIT_DIR)
                count += 1 if looped else 0
                map = initialise_map()

                patrol_count += 1
                print(patrol_count)

    return count


map = initialise_map()
print(part1(map))


map = initialise_map()
print(part2(map))
