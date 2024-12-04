from gettext import find
import re

# Example string
with open("./data/day3.txt", "r") as file:
    data = file.read()


def evaluate_mul(expr):
    """
    mul(X, Y) -> X * Y
    """
    a, b = expr.replace("mul(", "").replace(")", "").split(",")
    return int(a) * int(b)


def find_all_mul_expressions(s: str):
    pattern = r"mul\(\d{1,3},\d{1,3}\)"
    return re.findall(pattern, s)


def remove_disabled_region(s: str):
    parts = s.split("do()", maxsplit=1)
    return parts[1] if len(parts) > 1 else ""


def find_all_enabled_regions(s: str):

    def rec_find_all_enabled_regions(s: str, acc):
        """
        Recursively find all enabled regions in the string
        """
        s = remove_disabled_region(s)
        
        # no more enabled regions
        if s == "":
            return acc

        parts = s.split("don't()", maxsplit=1)

        # no don't() found, enitre string is enabled
        if len(parts) == 1:
            return acc + [parts[0]]
        # don't() found, left handside is the enabled part, add to the acc and continue
        else:
            enabled, rest = parts
            return rec_find_all_enabled_regions(rest, acc=acc + [enabled])

    # the first set of mul expressions before the first "don't()" are enabled
    enabled, rest = s.split("don't()", maxsplit=1)
    return rec_find_all_enabled_regions(rest, acc=[enabled])


def part1(input: str):
    sum = 0
    pattern = r"mul\(\d{1,3},\d{1,3}\)"
    matches = re.findall(pattern, input)
    for match in matches:
        sum += evaluate_mul(match)
    return sum


def part2(input: str):
    return sum(part1(s) for s in find_all_enabled_regions(input))


part1_ans = part1(data)
part2_ans = part2(data)

print(part1_ans)
print(part2_ans)
