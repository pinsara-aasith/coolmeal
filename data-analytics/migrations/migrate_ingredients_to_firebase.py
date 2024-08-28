import pandas as pd
import random
import firebase_admin
from google.cloud.firestore_v1.base_query import FieldFilter, BaseCompositeFilter
from firebase_admin import credentials, firestore

cred = credentials.Certificate('../keys/firebase_private_key.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

collection_name = 'ingredients'

def snake_to_camel(snake_str):
    words = snake_str.split('_')
    camel_case_str = words[0] + ''.join(word.capitalize() for word in words[1:])
    return camel_case_str

def clean_column_name(column_name):
    return snake_to_camel(column_name.replace(" ", "_").replace("(", "_").replace(")", "").replace(",", "").replace('µ','u').lower())

csv_file_path = '../datasets/ingredients/final_ingredients.csv'
df = pd.read_csv(csv_file_path)

# Clean the column names
df.columns = [clean_column_name(col) for col in df.columns]

print(df.head())

for _, row in df.iterrows():
    row_dict = row.dropna().to_dict()  # Remove any NaN values
    food_code = row_dict.get('foodCode')
    
    query = db.collection(collection_name).where(filter=FieldFilter('foodCode', '==', food_code)).get()
    if query:
        for doc in query: 
            doc_ref = db.collection(collection_name).document(doc.id)
            doc_ref.update(row_dict)
            print(f"Updated ingredient: {row_dict.get('foodName')}")
    else:
        db.collection(collection_name).add(row_dict)
        print(f"Added new ingredient: {row_dict.get('foodName')}")
        print(row_dict)


print(f"Ingredients data has been uploaded to the '{collection_name}' collection in Firestore.")

