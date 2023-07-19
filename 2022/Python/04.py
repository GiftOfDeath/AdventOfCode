# part 1
file = open("input/04.txt")

total = 0
for line in file:
    line = line.replace(",","-")
    sections = line.split("-")

    if( (int(sections[0]) >= int(sections[2]) and int(sections[1]) <= int(sections[3])) or
        (int(sections[2]) >= int(sections[0]) and int(sections[3]) <= int(sections[1])) ):
        total += 1

print(total)
file.close()

# part 2
file = open("input/04.txt")

total = 0
for line in file:
    line = line.replace(",","-")
    sections = line.split("-")

    if( (int(sections[0]) >= int(sections[2]) and int(sections[1]) <= int(sections[3])) or
        (int(sections[2]) >= int(sections[0]) and int(sections[3]) <= int(sections[1])) or
        (int(sections[0]) <  int(sections[2]) and int(sections[1]) <  int(sections[3]) and int(sections[1]) >= int(sections[2])) or
        (int(sections[2]) <  int(sections[0]) and int(sections[3]) <  int(sections[1]) and int(sections[3]) >= int(sections[0])) ):
        total += 1

print(total)
file.close()