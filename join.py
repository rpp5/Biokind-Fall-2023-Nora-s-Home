import pandas as pd

guest_data = pd.read_csv('data/guest_data.csv')
output = pd.read_csv('data/output.csv')

print(guest_data.shape)
# (873, 22)

print(output.shape)
# (873, 3)

zipcode_to_income = {}

for _, row in output.iterrows():
    print(row)
    zipcode_to_income[row['zipcode']] = row['income']

print(zipcode_to_income)

for _, row in guest_data.iterrows():
    zipcode = row['ZIP']
    if zipcode in zipcode_to_income:
        guest_data.at[_, 'income'] = zipcode_to_income[zipcode]
    else:
        guest_data.at[_, 'income'] = -1

guest_data.to_csv('data/guest_data_with_income.csv', index=False)