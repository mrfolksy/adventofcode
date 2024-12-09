from itertools import combinations, product

with open("./data/day7.txt") as f:
    input = f.read().split("\n")

# key = number of slots
# value = an arrary of all possible combinations of + and *
combinations_map = {}


def get_combinations(n: int):
    if n not in combinations_map:
        combinations_map[n] = [c for c in product(["+", "*"], repeat=n)]
    return combinations_map[n]


def parse_equation(line: str):
    parts = line.split(":")
    return (int(parts[0]), [int(n) for n in parts[1][1:].split(" ")])


def evaluate(numbers: list[int], operators: list[str]):
    total = 0

    for i, v in enumerate(operators):
        lhs = total if total != 0 else numbers[i]
        rhs = numbers[i + 1]
        total = eval(f"{lhs}{v}{rhs}")

    return total


def part1(input):
    ans = 0

    for line in input:
        test_val, numbers = parse_equation(line)

        for c in get_combinations(len(numbers) - 1):
            result = evaluate(numbers, c)
            if result == test_val:
                ans += result
                break

    return ans


print(part1(input))
