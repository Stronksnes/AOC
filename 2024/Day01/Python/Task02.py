import os
from collections import Counter

def processLines(file_path):
    
    array1 = []
    array2 = []

    with open(file_path, 'r') as file:
        lines = file.readlines()
        for line in lines:
            linesplit = line.split()
            array1.append(int(linesplit[0]))
            array2.append(int(linesplit[1]))
    
    counts = Counter(array2)
    
    processed_lines = []
    for instance in array1:
        times_found = counts.get(instance, 0)
        similarity_score = instance * times_found
        processed_lines.append({
            'Number': instance,
            'TimesFound': times_found,
            'SimilarityScore': similarity_score
        })

    return processed_lines

filePath = os.path.join("..", "input.txt")
processed_lines = processLines(filePath)

similarity_scores = []
for line in processed_lines:
    similarity_scores.append(line['SimilarityScore'])
    print(line)

print(similarity_scores)
print(sum(similarity_scores))