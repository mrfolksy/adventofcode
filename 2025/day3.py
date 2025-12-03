import heapq

with open("data/day3.txt") as f:
    data = f.readlines()


def part1(bank: str):
    max_heap = []

    for i in range(0, len(bank)):
        for j in range(i + 1, len(bank)):
            heapq.heappush(max_heap, -int(f"{bank[i]}{bank[j]}"))

    return -heapq.heappop(max_heap)


def part2(bank: str):
    stack = []
    to_remove = len(bank) - 13

    for i in bank.strip():
        val = int(i)
        while stack and to_remove > 0 and val > stack[-1]:
            stack.pop()
            to_remove -= 1
        stack.append(val)

    return int("".join([str(s) for s in stack[:12]]))


def run(func):
    res = 0
    for bank in data:
        res += func(bank)

    return res


print(f"Part 1: {run(part1)}")
print(f"Part 2: {run(part2)}")
