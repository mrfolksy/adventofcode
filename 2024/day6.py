from typing import Literal

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


def visit(map, loc: tuple, dir: Direction, tag=None) -> int:
    curr_value = map[loc[0]][loc[1]]
    ret = 1 if curr_value in (".", "^") else 0

    if curr_value == "+":
        return ret

    if dir == "N" or dir == "S":
        if curr_value == "|":
            map[loc[0]][loc[1]] = "|"
        if curr_value == "-":
            map[loc[0]][loc[1]] = "+"
        else:
            map[loc[0]][loc[1]] = "|"

    if dir == "E" or dir == "W":
        if curr_value == "-":
            map[loc[0]][loc[1]] = "-"
        if curr_value == "|":
            map[loc[0]][loc[1]] = "+"
        else:
            map[loc[0]][loc[1]] = "-"

    return ret


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
    if start_loc == loc:
        return True


def sum_visited_locations(map):
    count = 0
    for row in map:
        for cell in row:
            if cell in ("X", "|", "-", "+"):
                count += 1
    return count


def patrol(map, guard_loc: tuple, start_dir: Direction) -> bool:
    """
    Runs a guard patrol, returns True if the guard ends up in a loop, returns False
    if the guard wonders out of the map
    """
    loc = guard_loc
    facing = start_dir
    visited = set()

    while True:
        if (loc, facing) in visited:
            return True

        ahead = lookahead(map, loc, facing)
        if ahead == "#" or ahead == "O":
            facing = turn(facing)
        else:
            next_loc = step(loc, facing)
            if is_inmap(map, next_loc):
                visit(map, loc, facing)
                visited.add((loc, facing))
                loc = next_loc
            else:
                visit(map, loc, facing)
                break

    return False


def part1(map):
    patrol(map, start_loc(map), INIT_DIR)
    return sum_visited_locations(map)


def part2(map):
    count = 0
    guard_loc = start_loc(map)

    for i in range(0, len(map)):
        for j in range(0, len(map[0])):
            if map[i][j] == ".":
                map[i][j] = "O"
                looped = patrol(map, guard_loc, INIT_DIR)
                count += 1 if looped else 0
                map = initialise_map()

    return count


map = initialise_map()
print(part1(map))

map = initialise_map()
print(part2(map))
