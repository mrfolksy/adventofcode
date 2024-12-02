from functools import reduce


with open("./data/day2.txt") as f:
    data = f.readlines()


def parse_report(line):
    return [int(i) for i in line.split(" ")]


def calc_deltas(report: list[int]):
    deltas = []

    for i in range(len(report) - 1, 0, -1):
        delta = report[i] - report[i - 1]
        deltas = [delta, *deltas]

    return deltas


def meets_conditions(lst: list[int], condition):
    return all(condition(item) for item in lst)


def is_safe_with_dampener(report: list[int]):
    for i in range(len(report)):
        if is_safe_report(report[:i] + report[i + 1 :]):
            return True
    return False


def is_safe_report(report: list[int]):
    deltas = calc_deltas(report)
    return (
        meets_conditions(deltas, lambda x: x > 0)
        or meets_conditions(deltas, lambda x: x < 0)
    ) and meets_conditions(deltas, lambda x: 1 <= abs(x) <= 3)


def part1():
    total_safe = 0
    for line in data:
        report = parse_report(line)
        total_safe += 1 if is_safe_report(report) else 0

    print(total_safe)


def part2():
    total_safe = 0
    for line in data:
        report = parse_report(line)
        if is_safe_report(report):
            total_safe += 1
        elif is_safe_with_dampener(report):
            total_safe += 1

    print(total_safe)


part1()
part2()
