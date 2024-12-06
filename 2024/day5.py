with open("./data/day5.txt") as f:
    input = f.read().split("\n")

rules = set()
updates = []

for line in input:
    if "|" in line:
        rules.add(line)
    if "," in line:
        updates.append(line)


def is_valid_update(rules: set[str], update: list[int]):
    """
    Returns a tuple with a boolean indicating if the update is valid. If the update is invalid
    it also returns a dictionary with the index of a value and the number of times it violated the order rules
    """
    violations = {}
    for i, _ in enumerate(update):
        for _, v in enumerate(update[i + 1 :]):
            if f"{update[i]}|{v}" not in rules:
                violations[i] = violations.get(i, 0) + 1

    return (len(violations) == 0, violations)


def fix_invalid_update(update: list[int], violations: dict[int, int]):
    """
    take an invalid update, take the first violation which is a dictionary
     - key - the index of the value that is out of order
     - value - number of times it violated the order rules

    1) shift the value to the right by the number of times it violated the order rules
    2) check if the update array is now valid, if not repeat the process
    """
    while True:
        idx, count = violations.popitem()
        value = update.pop(idx)
        update.insert(idx + count, value)

        is_valid, violations = is_valid_update(rules, update)
        if is_valid:
            return update


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
            fixed_updates.append(fix_invalid_update(update, violations))

    total = 0
    for update in fixed_updates:
        total += update[int(len(update) / 2)]

    return total


print(part1(rules, updates))
print(part2(rules, updates))
