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
    for i, _ in enumerate(update):
        for _, v in enumerate(update[i + 1 :]):
            if f"{update[i]}|{v}" not in rules:
                return False
    return True


def part1(rules, updates):
    valid_updates = []
    for update in updates:
        update = [int(s) for s in update.split(",")]
        if is_valid_update(rules, update):
            valid_updates.append(update)

    total = 0
    for update in valid_updates:
        total += update[int(len(update) / 2)]

    return total


print(part1(rules, updates))
