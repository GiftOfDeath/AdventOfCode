# part 1
file = open("input/03.txt")

total = 0
items = set()
comp1 = set()
comp2 = set()
for line in file:
    items.clear()
    comp1.clear()
    comp2.clear()
    line = line.strip()
    # print(str(len(line))+" "+str(int(len(line)/2))+" "+str(int(len(line)/2)))
    for char in line[:int(len(line)/2)]:
        comp1.add(char)
    for char in line[int(len(line)/2):]:
        comp2.add(char)
    
    #print(str(comp1) + " | " + str(comp2))
    items = items.union(comp1.intersection(comp2))
    for item in items:
        if ord(item) >= 97:
            total += ord(item)-96 # 97 = a, a-z = 1-26
        else:
            total += ord(item)-65+27 # 65 = A, A-Z = 27-52

file.close()
print(total)

# part 2
file = open("input/03.txt")


total = 0
items = set()
sack1 = set()
sack2 = set()
sack3 = set()
i = 0
for line in file:
    if i % 3 == 0:
        sack1.clear()
        sack2.clear()
        sack3.clear()
        items.clear()

    line = line.strip()
    for char in line:
        if i % 3 == 0:
            sack1.add(char)
        elif i % 3 == 1:
            sack2.add(char)
        else:
            sack3.add(char)
    i += 1
    
    if( i % 3 == 0 ):
        items = (sack1.intersection(sack2)).intersection(sack3)
        for item in items:
            if ord(item) >= 97:
                total += ord(item)-96 # 97 = a, a-z = 1-26
            else:
                total += ord(item)-65+27 # 65 = A, A-Z = 27-52

file.close()

print(total)
