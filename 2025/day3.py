import heapq

with open("data/day3.txt") as f:
    data = f.readlines()


def part1(bank: str):
    max_heap = []

    for i in range(0, len(bank)):
        for j in range(i + 1, len(bank)):
            heapq.heappush(max_heap, -int(f"{bank[i]}{bank[j]}"))

    return -heapq.heappop(max_heap)


def run(func):
    res = 0
    for bank in data:
        res += func(bank)

    return res


print(f"{run(part1)}")
