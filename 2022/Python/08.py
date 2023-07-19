# parse input
file = open("input/08.txt")

forest = list()

for line in file:
    forest.append(list())
    line = line.rstrip()

    for tree in line:
        forest[len(forest)-1].append(int(tree))

file.close()

# part 1

# add all the edge trees to the total as visible ((width+height) * 2 - 4)
total = (len(forest)+len(forest[0]))*2-4

for y in range(1,len(forest)-1):
    for x in range(1,len(forest[y])-1):
        visible = 4
        tree = forest[y][x]
        
        for i in range(0,x):
            if forest[y][i] >= tree:
                visible -= 1
                break
            
        for i in range(x+1,len(forest[y])):
            if forest[y][i] >= tree:
                visible -= 1
                break
            
        for i in range(0,y):
            if forest[i][x] >= tree:
                visible -= 1
                break
        
        for i in range(y+1,len(forest)):
            if forest[i][x] >= tree:
                visible -= 1
                break

        if visible > 0:
            print(str(x)+","+str(y)+" is visible!")
            total += 1
        else:
            print(str(x)+","+str(y)+" is not visible!")
            
print("")

# part 2

highscore = 0
for y in range(1,len(forest)-1):
    for x in range(1,len(forest[y])-1):
        score = 0
        tree = forest[y][x]
        
        for i in range(x-1,-1,-1):
            if forest[y][i] >= tree or i == 0:
                score = x-i
                break
            
        for i in range(x+1,len(forest[y])):
            if forest[y][i] >= tree or i == len(forest[y])-1:
                score *= i-x
                break
            
        for i in range(y-1,-1,-1):
            if forest[i][x] >= tree or i == 0:
                score *= y-i
                break
        
        for i in range(y+1,len(forest)):
            if forest[i][x] >= tree or i == len(forest)-1:
                score *= i-y
                break

        print(str(x)+","+str(y)+" score: "+str(score))
        if score > highscore:
            highscore = score


print("P1: "+str(total))
print("P2: "+str(highscore))