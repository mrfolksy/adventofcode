from itertools import product

with open("./data/day7.txt") as f:
    input = f.read().split("\n")

# key = number of slots
# value = an arrary of all possible combinations of + and *
combinations_map = {}


def get_combinations(n: int, operators):
    if n not in combinations_map:
        combinations_map[n] = [c for c in product(operators, repeat=n)]
    return combinations_map[n]


def parse_equation(line: str):
    parts = line.split(":")
    return (int(parts[0]), [int(n) for n in parts[1][1:].split(" ")])


def evaluate(numbers: list[int], operators: list[str]):
    total = 0

    for i, o in enumerate(operators):
        lhs = total if total != 0 else numbers[i]
        rhs = numbers[i + 1]

        if o == "||":
            total = int(f"{lhs}{rhs}")
        else:
            total = eval(f"{lhs}{o}{rhs}")

    return total


def run(input, operators: list[str] = ["+", "*"]):
    ans = 0

    for line in input:
        test_val, numbers = parse_equation(line)

        for c in get_combinations(len(numbers) - 1, operators):
            result = evaluate(numbers, c)
            if result == test_val:
                ans += result
                break

    return ans


def part1(input):
    return run(input)


def part2(input):
    return run(input, ["+", "*", "||"])


print(part1(input))
print(part2(input))
