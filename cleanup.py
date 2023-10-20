import pandas as pd

guest_data = pd.read_csv('data/guest_data.csv')

zip_column = guest_data['ZIP'][1:]

zip_column_int = [int(zip) for zip in zip_column]

with open('data/zipcode.txt', 'w') as file:
    for zip in zip_column_int:
        file.write(str(zip) + '\n')
