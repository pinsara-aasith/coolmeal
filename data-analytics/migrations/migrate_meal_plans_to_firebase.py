import pandas as pd
import random
import firebase_admin
from google.cloud.firestore_v1.base_query import FieldFilter, BaseCompositeFilter
from firebase_admin import credentials, firestore

cred = credentials.Certificate('../keys/firebase_private_key.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

collection_name = 'meal_plans'

def snake_to_camel(snake_str):
    words = snake_str.split('_')
    camel_case_str = words[0] + ''.join(word.capitalize() for word in words[1:])
    return camel_case_str

def clean_column_name(column_name):
    return snake_to_camel(column_name.replace(" ", "_").replace("(", "_").replace(")", "").replace(",", "").replace('µ','u').lower())

csv_file_path = '../datasets/meals/final_meal_combinations_dataset.csv'
df = pd.read_csv(csv_file_path)

# Clean the column names
df.columns = [clean_column_name(col) for col in df.columns]


# Randomly select 10 meals and set generatedTimes to 1
random_indices_1 = random.sample(range(len(df)), 10)
df.loc[random_indices_1, 'generatedTimes'] = 1

# Randomly select another 10 meals and set generatedTimes to 2
remaining_indices = list(set(range(len(df))) - set(random_indices_1))
random_indices_2 = random.sample(remaining_indices, 10)
df.loc[random_indices_2, 'generatedTimes'] = 2

all_selected_indices = set(random_indices_1 + random_indices_2)
df.loc[~df.index.isin(all_selected_indices), 'generatedTimes'] = 0

print(df.head())

for _, row in df.iterrows():
    row_dict = row.dropna().to_dict()  # Remove any NaN values
    breakfast = row_dict.get('breakfast')
    lunch = row_dict.get('lunch')
    dinner = row_dict.get('dinner')
    
    query = db.collection(collection_name) \
        .where(filter=FieldFilter('breakfast', '==', breakfast)) \
        .where(filter=FieldFilter('lunch', '==', lunch)) \
        .where(filter=FieldFilter('dinner', '==', dinner)) \
        .get()
    
    if query:
        for doc in query:
            doc_ref = db.collection(collection_name).document(doc.id)
            doc_ref.update(row_dict)
            print(f"Updated meal: {breakfast}, {lunch}, {dinner}")
    else:
        db.collection(collection_name).add(row_dict)
        print(f"Added new meal: {breakfast}, {lunch}, {dinner}")
        print(row_dict)


print(f"Meal planss data has been uploaded to the '{collection_name}' collection in Firestore.")

