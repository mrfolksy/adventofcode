with open("./data/day4.txt") as f:
    input = f.read().split("\n")


def get_letter_matrix(s: str):
    matrix = []
    for l in s:
        matrix.append([c for c in l])
    return matrix


def match_horizontal(i, j, matrix, step=1):
    """
    .,.,.,.,.,.,.
    .,.,.,.,.,.,.
    .,.,.,.,.,.,.
    S,A,M,X,M,A,S
    .,.,.,.,.,.,.
    .,.,.,.,.,.,.
    ,,.,.,.,.,.,.
    """
    try:
        if j + 1 * step < 0:
            return False
        if j + 2 * step < 0:
            return False
        if j + 3 * step < 0:
            return False

        return (
            matrix[i][j] == "X"
            and matrix[i][j + 1 * step] == "M"
            and matrix[i][j + 2 * step] == "A"
            and matrix[i][j + 3 * step] == "S"
        )
    except:
        return False


def match_vertical(i, j, matrix, step=1):
    """
    .,.,.,S,.,.,.
    .,.,.,A,.,.,.
    .,.,.,M,.,.,.
    .,.,.,X,.,.,.
    .,.,.,M,.,.,.
    .,.,.,A,.,.,.
    .,.,.,S,.,.,.
    """
    try:
        if i + 1 * step < 0:
            return False
        if i + 2 * step < 0:
            return False
        if i + 3 * step < 0:
            return False

        return (
            matrix[i][j] == "X"
            and matrix[i + 1 * step][j] == "M"
            and matrix[i + 2 * step][j] == "A"
            and matrix[i + 3 * step][j] == "S"
        )
    except:
        return False


def match_diagonal(
    i,
    j,
    matrix,
    vstep=1,
    hstep=1,
):
    """
    S,.,.,.,.,.,S
    .,A,.,.,.,A,.
    .,.,M,.,M,.,.
    .,.,.,X,.,.,.
    .,.,M,.,M,.,.
    .,A,.,.,.,A,.
    S,.,.,.,.,.,S
    """
    try:
        if i + 1 * vstep < 0 or j + 1 * hstep < 0:
            return False
        if i + 2 * vstep < 0 or j + 2 * hstep < 0:
            return False
        if i + 3 * vstep < 0 or j + 3 * hstep < 0:
            return False

        return (
            matrix[i][j] == "X"
            and matrix[i + 1 * vstep][j + 1 * hstep] == "M"
            and matrix[i + 2 * vstep][j + 2 * hstep] == "A"
            and matrix[i + 3 * vstep][j + 3 * hstep] == "S"
        )
    except:
        return False


def part1(matrix):
    """
    S,.,.,S,.,.,S
    .,A,.,A,.,A,.
    .,.,M,M,M,.,.
    S,A,M,X,M,A,S
    .,.,M,M,M,.,.
    .,A,.,A,.,A,.
    S,.,.,S,.,.,S
    """

    word_count = 0
    for i in range(0, 140):
        for j in range(0, 140):
            # horizontal match (3,2)
            word_count += 1 if match_horizontal(i, j, matrix, 1) else 0
            word_count += 1 if match_horizontal(i, j, matrix, -1) else 0
            # # vertical match (1,2)
            word_count += 1 if match_vertical(i, j, matrix, 1) else 0
            word_count += 1 if match_vertical(i, j, matrix, -1) else 0
            # # diagonal match down (1)
            word_count += 1 if match_diagonal(i, j, matrix, 1, -1) else 0
            word_count += 1 if match_diagonal(i, j, matrix, -1, -1) else 0
            # # diagonal match up
            word_count += 1 if match_diagonal(i, j, matrix, 1, 1) else 0
            word_count += 1 if match_diagonal(i, j, matrix, -1, 1) else 0

    return word_count


def part2(matrix):
    """
    M,.,S  M,.,M  S,.,M  S,.,S
    .,A,.  .,A,.  .,A,.  .,A,.
    M,.,S  S,.,S  S,.,M  M,.,M
    """
    word_count = 0
    for i in range(1, 139):
        for j in range(1, 139):
            pass


print(part1(input))
