with open("./data/day5.test.txt") as f:
    input = f.read().split("\n")

rules = set()
updates = []

for line in input:
    if "|" in line:
        rules.add(line)
    if "," in line:
        updates.append(line)


def is_valid_update(rules: set[str], update: list[int]):
    violations = {}
    for i, _ in enumerate(update):
        for _, v in enumerate(update[i + 1 :]):
            if f"{update[i]}|{v}" not in rules:
                violations[i] = violations.get(i, 0) + 1

    return (len(violations) == 0, violations)


def fix_invalid_update(update: list[int], violations: list[str]):
    pass


def part1(rules, updates):
    valid_updates = []
    for update in updates:
        update = [int(s) for s in update.split(",")]
        is_valid, _ = is_valid_update(rules, update)
        if is_valid:
            valid_updates.append(update)

    total = 0
    for update in valid_updates:
        total += update[int(len(update) / 2)]

    return total


def part2(rules, updates):
    fixed_updates = []

    for update in updates:
        update = [int(s) for s in update.split(",")]
        is_valid, violations = is_valid_update(rules, update)
        if not is_valid:
            print(update)
            print(violations)

    # total = 0
    # for update in fixed_updates:
    #     total += update[int(len(update) / 2)]

    # return total


# print(part1(rules, updates))
print(part2(rules, updates))
