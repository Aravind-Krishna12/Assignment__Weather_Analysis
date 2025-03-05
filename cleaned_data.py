import pandas as pd
df=pd.read_csv('GlobalWeatherRepository.csv')
print(df.head())
print(df.info())
print(df.shape)
#handle missing value
print(df.isnull().sum())
#checking for duplicates
duplicates = df.duplicated()
print(df[duplicates])
#clean and standarized column name
df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')
print(df['last_updated'].dtype)
df['last_updated'] = pd.to_datetime(df['last_updated'])
print(df['last_updated'].dtype)
output_path="weatherdatanew.csv"
df.to_csv(output_path, index=False)
