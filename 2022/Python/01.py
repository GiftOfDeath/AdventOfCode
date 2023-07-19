file = open("input/01.txt")

calories = []
count = 0
for line in file:
    if line == "\n":
        calories.append(count)
        count = 0
    else:
        count += int(line)
file.close()

calories.sort(reverse=True)
print(calories[0])
print(calories[0]+calories[1]+calories[2])