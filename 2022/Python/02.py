# part 1
file = open("input/02.txt")
score = 0

for line in file:
    if line[2] == "X":
        score += 1
        if line[0] == "A":
            score += 3
        elif line[0] == "B":
            score += 0
        else:
            score += 6

    elif line[2] == "Y":
        score += 2
        if line[0] == "A":
            score += 6
        elif line[0] == "B":
            score += 3
        else:
            score += 0

    else:
        score += 3
        if line[0] == "A":
            score += 0
        elif line[0] == "B":
            score += 6
        else:
            score += 3

file.close()

print(score)

# part 2
file = open("input/02.txt")
score = 0

for line in file:
    if line[2] == "X":
        if line[0] == "A": #lose
            score += 3 #scissors
        elif line[0] == "B":
            score += 1 #rock
        else:
            score += 2 #paper

    elif line[2] == "Y": #draw
        score += 3
        if line[0] == "A":
            score += 1 #rock
        elif line[0] == "B":
            score += 2 #paper
        else:
            score += 3 #scissors

    else: #win
        score += 6
        if line[0] == "A":
            score += 2 #paper
        elif line[0] == "B":
            score += 3 #scissors
        else:
            score += 1 #rock

file.close()

print(score)