import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
from datetime import datetime

"""
ID,Hospital,Gender,Address1,Address2,City,State,Country,ZIP,County,Email,Diagnosis,DiagnosisDetails,BirthdateMonth,BirthdateDate,BirthdateYear,Language,Ethnicity,Referral,PrimaryGuestId,PrimaryMedicalContactID,Notes
25968,CHI St. Luke's ,Male,3612 Hummingbird,,MCALLEN,TEXAS,United States,78504,HIDALGO,,Post Liver ,,8,12,1958,English,Hispanic,CHI St. Luke's ,0,0,SW - Ann Holder 832-955-3026
"""

file_path = 'data/guest_data_with_income.csv'
guest_data = pd.read_csv(file_path)

current_year = datetime.now().year
guest_data['Age'] = current_year - guest_data['BirthdateYear']

# Plot age distribution
plt.figure(figsize=(10, 6))
sns.histplot(guest_data['Age'], bins=30, kde=True)
plt.title('Age Distribution of Guests')
plt.xlabel('Age')
plt.ylabel('Frequency')
plt.grid(True)
plt.savefig('data/vis/Age_Distribution.png')

plt.figure(figsize=(12, 8))
sns.countplot(data=guest_data, y='Diagnosis', order=guest_data['Diagnosis'].value_counts().index)
plt.title('Frequency of Diagnoses')
plt.xlabel('Count')
plt.ylabel('Diagnosis')
plt.xticks(rotation=45)
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Diagnosis_Frequency.png')

plt.figure(figsize=(12, 8))
sns.countplot(data=guest_data, x='Ethnicity')
plt.title('Ethnicity Distribution of Guests')
plt.xlabel('Ethnicity')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Ethnicity_Distribution.png')

plt.figure(figsize=(10, 6))
sns.histplot(guest_data['income'], bins=30, kde=True)
plt.title('Income Distribution of Guests')
plt.xlabel('Income')
plt.ylabel('Frequency')
plt.grid(True)
plt.savefig('data/vis/Income_Distribution.png')

plt.figure(figsize=(12, 8))
guest_data['Language'].value_counts().plot(kind='bar')
plt.title('Language Distribution of Guests')
plt.xlabel('Language')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Language_Distribution.png')

plt.figure(figsize=(12, 8))
sns.boxplot(data=guest_data, x='Gender', y='income')
plt.title('Income Distribution by Gender')
plt.xlabel('Gender')
plt.ylabel('Income')
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Income_Distribution_by_Gender.png')

plt.figure(figsize=(12, 8))
sns.countplot(data=guest_data, y='Referral', order=guest_data['Referral'].value_counts().index)
plt.title('Referral Sources for Guests')
plt.xlabel('Count')
plt.ylabel('Referral Source')
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Referral_Sources.png')

plt.figure(figsize=(12, 8))
sns.countplot(data=guest_data, x='Hospital', hue='Gender')
plt.title('Gender Distribution by Hospital')
plt.xlabel('Hospital')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.legend(title='Gender')
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Gender_Distribution_by_Hospital.png')

hospital_counts = guest_data['Hospital'].value_counts()
plt.figure(figsize=(12, 8))
hospital_counts.plot(kind='bar')
plt.title('Number of Guests by Hospital')
plt.xlabel('Hospital')
plt.ylabel('Number of Guests')
plt.xticks(rotation=45)
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Number_of_Guests_by_Hospital.png')

plt.figure(figsize=(12, 8))
sns.barplot(data=guest_data, x='Hospital', y='income')
plt.title('Average Income by Hospital')
plt.xlabel('Hospital')
plt.ylabel('Average Income')
plt.xticks(rotation=45)
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Average_Income_by_Hospital.png')

plt.figure(figsize=(10, 6))
plt.scatter(range(guest_data.shape[0]), guest_data['income'], alpha=0.6, color='blue')
plt.title('Income Distribution of Guests')
plt.xlabel('Guest Index')
plt.ylabel('Income')
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Income_Scatter.png')

plt.figure(figsize=(12, 6))
sns.stripplot(y=guest_data['income'], jitter=0.2, size=4, color='blue', alpha=0.6)
plt.title('Income Distribution of Guests')
plt.ylabel('Income')
plt.grid(True)
plt.tight_layout()
plt.savefig('data/vis/Income_Jitter_Plot.png')

plt.close('all')

