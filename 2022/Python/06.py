# part 1

file = open("input/06.txt")

for line in file:
    line = line.rstrip() # kinda redundant tbh
    
    markerLength = 4
    for i in range(len(line)-markerLength):
        # make a set out of the string range to easily identify the marker of n-characters
        if( len(set(line[i:i+markerLength])) == markerLength ):
            print(i+markerLength)
            break

file.close()

# part 2
file = open("input/06.txt")

for line in file:
    line = line.rstrip() # kinda redundant tbh

    markerLength = 14
    for i in range(len(line)-markerLength):
        # make a set out of the string range to easily identify the marker of n-characters
        if( len(set(line[i:i+markerLength])) == markerLength ):
            print(i+markerLength)
            break

file.close()