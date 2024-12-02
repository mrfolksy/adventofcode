with open("./data/day2.txt") as f:
    data = f.readlines()

def parse_line(line): 
    return [int(i) for i in line.split(" ")]

def calc_deltas(report_vals):
    return [
        report_vals[1] - report_vals[0],
        report_vals[2] - report_vals[1],
        report_vals[3] - report_vals[2],
        report_vals[4] - report_vals[3],
        report_vals[5] - report_vals[4],
    ]

def is_safe_report(report_vals):
    deltas = calc_deltas(report_vals)
    

def part1():
    for line in data:
        report_vals = parse_line(line)
