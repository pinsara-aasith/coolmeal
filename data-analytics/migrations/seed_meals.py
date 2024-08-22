import csv
from pymongo import MongoClient
from dotenv import load_dotenv
import os

load_dotenv()

uri = os.getenv("MONGODB_URI")
db_name = os.getenv("DB_NAME")
collection_name = "meals"

csv_file_path = "../datasets/meals/meals.csv"

client = MongoClient(uri)
db = client[db_name]
collection = db[collection_name]

with open(csv_file_path, mode='r') as file:
    csv_reader = csv.DictReader(file)
    
    for row in csv_reader:
        ingredient_quantities = [float(quantity) for quantity in row['Meal_Ingredient_Quantities'].split(',')]
        ingredients = row['Meal_Ingredients'].split(',')
        
        meal_document = {
            "meal_id": int(row['Meal_Id']),
            "name": row['Name'],
            "ingredients": ingredients,
            "ingredient_quantities": ingredient_quantities,
            "category": row['Category'],
            "description": row['Description']
        }
        
        collection.update_one(
            {"meal_id": int(row['Meal_Id'])},
            {"$set": meal_document},
            upsert=True
        )
print("Data processed successfully")

client.close()
