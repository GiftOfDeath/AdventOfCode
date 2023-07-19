import re

# part 1
file = open("input/05.txt")

start = True
containers = list()
for line in file:
    line = line.rstrip()

    if start:
        if line == "":
            start = False
            print(containers)
            continue

        i = 1
        while(i < len(line)):
            pos = int((i-1)/4) # pick just every 4th character since they're the relevant ones

            if len(containers) <= pos: # if there's no list for the container pile yet create one
                containers.append(list())

            if line[i].isalpha(): # only add a container in the pile if it's a letter A-Z
                containers[pos].insert(0,line[i])
            i += 4
    else:
        instruction = [int(n) for n in (re.sub(r"([a-z])\w+(\s)","",line)).split(" ")] # use regex to remove words and extra spaces, loop split to turn into integers
        instruction[1] -= 1
        instruction[2] -= 1
        # copy and remove containers from the stacks
        for i in range(instruction[0]):
            containers[instruction[2]].append(containers[instruction[1]][len(containers[instruction[1]])-1])
            containers[instruction[1]].pop(len(containers[instruction[1]])-1)

answer = ""
for pile in containers:
    answer += pile[len(pile)-1]

print(answer)
file.close()
print()
# part 2
file = open("input/05.txt")

start = True
containers = list()
for line in file:
    line = line.rstrip()

    if start:
        if line == "":
            start = False
            print(containers)
            continue

        i = 1
        while(i < len(line)):
            pos = int((i-1)/4) # pick just every 4th character since they're the relevant ones

            if len(containers) <= pos: # if there's no list for the container pile yet create one
                containers.append(list())

            if line[i].isalpha(): # only add a container in the pile if it's a letter A-Z
                containers[pos].insert(0,line[i])
            i += 4
    else:
        instruction = [int(n) for n in (re.sub(r"([a-z])\w+(\s)","",line)).split(" ")] # use regex to remove words and extra spaces, loop split to turn into integers
        instruction[1] -= 1
        instruction[2] -= 1
        # copy the end of one stack on top of another
        containers[instruction[2]].extend(containers[instruction[1]][len(containers[instruction[1]])-instruction[0]:len(containers[instruction[1]])])
        # remove the copied elements from the original
        del containers[instruction[1]][-instruction[0]:]
        
answer = ""
for pile in containers:
    answer += pile[len(pile)-1]

print(answer)
file.close()