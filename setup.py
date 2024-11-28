import os

def createFolderStructure(year, minDay, maxDay, langList):
    for i in range(minDay, (maxDay + 1)):
        try:
            folderName = f'Day{i:02}'   

            dayPath = os.path.join('.', year, folderName)
            os.makedirs(dayPath)
            print(f"Folder '{dayPath}' created successfully.")
        
        except FileExistsError:
            print(f"Folder '{dayPath}' already exists.")
            
        for lang in langList:
            try:
                taskPath = os.path.join(dayPath, lang)
                os.makedirs(taskPath)
                print(f"Folder '{taskPath}' created successfully.")

            except FileExistsError:
                print(f"Folder '{taskPath}' already exists.")

year = '2024'
createFolderStructure(year, 1, 24, ['Powershell', 'Python', 'Go'])