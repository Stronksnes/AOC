import requests
import os
from dotenv import load_dotenv
from datetime import date
import sys

def getInput(year, day, session):

    url = f'https://adventofcode.com/{year}/day/{day}/input'
    cookies = {'session': session}

    response = requests.get(url, cookies=cookies)

    if response.status_code == 200:
        inputPath = os.path.join('.', str(year), f'Day{day:02}', 'input.txt')

        with open(inputPath, 'w') as file:
            file.write(response.text)

        print(f"Input for Day {day} saved successfully.")
    else:
        print(f"Failed to retrieve input for Day {day}.")

load_dotenv()

session = os.getenv('SESSION')
if not session:
    print("Failed to retrieve session cookie.")
    sys.exit(1)

if (date.today().month == 12):
    today = date.today().day
    year = date.today().year
else:
    print ("ITS NOT DECEMBER YET!")
    sys.exit(1)

for day in range(1, (today + 1)):
    getInput(year, day, session)