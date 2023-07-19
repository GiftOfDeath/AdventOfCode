# parse input for both parts
file = open("input/07.txt")

fileTree = dict(root = [dict(),0])
curFold = fileTree["root"]
curPath = list()
line = file.readline()
cmd = list()
viableDirs = list("root")
while line != "":
    # read line from input file, strip newline and split
    cmd = line.rstrip().split(" ")

    if( cmd[0] == "$" ):
        if( cmd[1] == "cd" ):
            if( cmd[2].isalpha() ):
                curPath.append(cmd[2])
                curFold = curFold[0][cmd[2]]
            elif( cmd[2] == ".." ):
                curPath.pop(len(curPath)-1)
                curFold = fileTree["root"]
                for p in curPath:
                    curFold = curFold[0][p]
            else:
                curFold = fileTree["root"]
                curPath.clear()
    else:
        if( cmd[0] == "dir" ):
            curFold[0][cmd[1]] = [dict(),0]
            viableDirs.append(cmd[1])
        else:
            curFold[0][cmd[1]] = int(cmd[0])
            curFold[1] += int(cmd[0])

            curFold = fileTree["root"]
            for p in curPath:
                curFold[1] += int(cmd[0])
                curFold = curFold[0][p]

    line = file.readline()
    
file.close()

# part 1
def recurse(d,limit):
    total = 0
    for a in d:
        if isinstance(d[a],list):
            if d[a][1] <= limit: 
                total += d[a][1]

            total += recurse(d[a][0],limit)

    return total

print(recurse(fileTree,100000))

# part 2
def recurse_min(d,result,limit):
    total = result
    for a in d:
        if isinstance(d[a],list):
            if d[a][1] >= limit and d[a][1] < result: 
                total = d[a][1]

            tmpTotal = recurse_min(d[a][0],total,limit)
            if( tmpTotal < total ):
                return tmpTotal

    return total

requiredSpace = 30000000
totalSpace = 70000000
print(recurse_min(fileTree,requiredSpace,fileTree["root"][1]-(totalSpace-requiredSpace)))
