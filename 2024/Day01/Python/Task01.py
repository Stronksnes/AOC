import os

def processLines(file_path):
    
    array1 = []
    array2 = []

    with open(file_path, 'r') as file:
        lines = file.readlines()
        for line in lines:
            linesplit = line.split()
            array1.append(int(linesplit[0]))
            array2.append(int(linesplit[1]))
    
    sortedArray1 = sorted(array1)
    sortedArray2 = sorted(array2)

    processedLines = []
    for i in range (len(sortedArray1)):
        processedLines.append({
            'Start': sortedArray1[i],
            'End': sortedArray2[i],
            'Distance': abs(sortedArray1[i] - sortedArray2[i])
        })
    
    return processedLines

filePath = os.path.join("..", "input.txt")
processedLines = processLines(filePath)

listDistances = []
for line in processedLines:
    listDistances.append(line['Distance'])
    print(line)

print(listDistances)

print(sum(listDistances))