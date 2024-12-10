with open("data/day8.test.txt") as f:
    input = f.read().split("\n")

# dictionary of anntena values and their locations
# key = antena symbol
# value = list of tupes (row, col)


def process_input():
    antenas_map = {}

    for i, line in enumerate(input):
        for j, sym in enumerate(line):
            if sym == ".":
                continue
            antenas = antenas_map.get(sym, None)
            if not antenas:
                antenas_map[sym] = []

            antenas_map[sym].append((i, j))
    return antenas_map


def antinode(fst: tuple[int, int], snd: tuple[int, int]):
    pass


def part1(antenas_map):
    for key, antenas in antenas_map.items():
        pass


part1(process_input())
