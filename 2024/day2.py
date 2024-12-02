from functools import reduce


with open("./data/day2.txt") as f:
    data = f.readlines()


def parse_line(line):
    return [int(i) for i in line.split(" ")]


def calc_deltas(report_vals):
    deltas = []

    for i in range(len(report_vals) - 1, 0, -1):
        delta = report_vals[i] - report_vals[i - 1]
        deltas = [delta, *deltas]

    return deltas


def meets_conditions(lst, condition):
    return all(condition(item) for item in lst)


def is_safe_report(deltas):
    return (
        meets_conditions(deltas, lambda x: x > 0)
        or meets_conditions(deltas, lambda x: x < 0)
    ) and meets_conditions(deltas, lambda x: 1 <= abs(x) <= 3)


def part1():
    total_safe = 0
    for report in data:
        report_vals = parse_line(report)
        deltas = calc_deltas(report_vals)
        total_safe += 1 if is_safe_report(deltas) else 0

    print(total_safe)


part1()
