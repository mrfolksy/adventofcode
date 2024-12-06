from typing import Literal

with open("./data/day6.txt") as f:
    input = f.read().split("\n")

map = []
for line in input:
    map.append([c for c in line])

"""
Directions:

    N
  W   E 
    S

Map Example:

....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""

Direction = Literal["N", "E", "S", "W"]

def getstart(map) -> tuple[int, int]:
    for i in range(0, len(map)):
        for j in range(0, len(map[0])):
            if map[i][j] == "^":
                return (i, j)
    return (0, 0)

def is_inmap(map, loc: tuple) -> bool:
    return (
        loc[0] >= 0 and loc[0] < len(map) 
        and 
        loc[1] >= 0 and loc[1] < len(map[0])
    )

def is_visited(map, loc: tuple) -> bool:
    return map[loc[0]][loc[1]] == "X"


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


def sum_visited_locations(map):
    count = 0
    for row in map:
        for cell in row:
            if cell == "X":
                count += 1
    return count


def part1(map):
    loc = getstart(map)
    facing = "N"

    while True:
        if lookahead(map, loc, facing) == "#":
            facing = turn(facing)
        else:
            next_loc = step(loc, facing)
            if is_inmap(map, next_loc):
                map[loc[0]][loc[1]] = "X"
                loc = next_loc
            else:
                map[loc[0]][loc[1]] = "X"
                break

    count = 0
    for row in map:
        for cell in row:
            if cell == "X":
                count += 1
    return count

result = part1(map)

for row in map:
    print("".join(row))

print(result)
