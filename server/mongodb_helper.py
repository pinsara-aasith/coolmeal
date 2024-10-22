from pymongo import MongoClient
from fastapi import HTTPException
from pymongo.errors import ConnectionFailure, OperationFailure
from dotenv import load_dotenv
from typing import List, Optional
import os

load_dotenv()
# Replace the following with your MongoDB Atlas connection string
MONGODB_URI = os.getenv("MONGO_URI")

# Initialize the MongoDB client
try:
    client = MongoClient(MONGODB_URI)
    print("Connected to MongoDB Atlas ---------------------------- ")
except ConnectionFailure as e:
    print(f"Could not connect to MongoDB: {e}")


# Helper function to serialize MongoDB ObjectId
def serialize_meal_plan(meal_plan):
    if isinstance(meal_plan, dict):
        # Convert ObjectId to string if it's a dict
        meal_plan["_id"] = str(meal_plan["_id"]) if "_id" in meal_plan else None
    return meal_plan


# Select the database and collection
db = client["cool-server"]
meal_plan_collection = db["Meal_plans"]
final_meals_collection = db["Final_Meals"]

print("Connected to the database and collection ---------------------------- ")


# Add method for get details of Meal plans using index
async def get_meal_plan_by_index(index: int):
    print("index -------------- ", index)

    try:
        meal_plan = meal_plan_collection.find_one({"index": index})
        return meal_plan
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
        return None


# Add method for get Total meal plans count
async def get_total_meal_plans_count():
    try:
        result = meal_plan_collection.count_documents({})
        print(f"Total Meal plans count: {result}")
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
    return result


# Add New Meal Plan to the database
async def add_new_meal_plan(meal_plan):
    try:
        result = meal_plan_collection.insert_one(meal_plan)
        print(f"Meal plan inserted with ID: {result}")
    except OperationFailure as e:
        print(f"Insert operation failed: {e}")
    return result


# Add method for get all Meal plans
async def get_all_meal_plans():
    meal_plans = []
    try:
        result = meal_plan_collection.find({})
        print(f"Meal plans found: {result}")
        for document in result:
            meal_plans.append(document)
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
    return meal_plans


# Get All Meals From Final_Melas Collection
async def get_all_meals():
    meals = []
    try:
        result = final_meals_collection.find({})
        print(f"Meals found: {result}")
        for document in result:
            meals.append(document)
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
    return meals


# Get Meal By 'Complete Meal' in Final Meals Collection
async def get_meal_by_name(complete_meal):
    try:
        meal = final_meals_collection.find_one({"Complete Meal": complete_meal})
        return meal
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
        return None


# Add method for get 50 meals that has the highest "Breakfast_Probability"
async def get_top_50_breakfast_meals():
    meals = []
    try:
        result = (
            final_meals_collection.find().sort("Breakfast_Probability", -1).limit(50)
        )
        print(f"Top 50 meals found: {result}")
        for document in result:
            meals.append(document)
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
    return meals


# Add method for get 50 meals that has the highest "Lunch_Probability"
async def get_top_50_lunch_meals():
    meals = []
    try:
        result = final_meals_collection.find().sort("Lunch_Probability", -1).limit(50)
        print(f"Top 50 meals found: {result}")
        for document in result:
            meals.append(document)
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
    return meals


# Add method for get 50 meals that has the highest "Dinner_Probability"
async def get_top_50_dinner_meals():
    meals = []
    try:
        result = final_meals_collection.find().sort("Dinner_Probability", -1).limit(50)
        print(f"Top 50 meals found: {result}")
        for document in result:
            meals.append(document)
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
    return meals


# Add method to insert new meal plan to the database  meal_plan_collection
async def insert_new_meal_plan(meal_plan):
    try:
        result = meal_plan_collection.insert_one(meal_plan)
        print(f"Meal plan inserted with ID: {result}")
    except OperationFailure as e:
        print(f"Insert operation failed: {e}")
    return result


# create method for get last document 'index' value in meal_plan_collection
async def get_last_index():
    try:
        result = meal_plan_collection.find().sort("index", -1).limit(1)
        print(f"Last index found: {result}")
        for document in result:
            return document["index"]
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
        return None


# Create method for insert new final meal to the database final_meals_collection
async def insert_new_final_meal(final_meal):
    try:
        result = final_meals_collection.insert_one(final_meal)
        # Retrieve the inserted meal using the ID
        inserted_meal = final_meals_collection.find_one({"_id": result.inserted_id})
        return inserted_meal
    except OperationFailure as e:
        print(f"Insert operation failed: {e}")
        raise HTTPException(
            status_code=500, detail=f"Insert operation failed: {str(e)}"
        )

ingredients_collection = db['Ingredients']  # Collection name

def read_all_ingredients():
    ingredients = list(ingredients_collection.find())
    return [convert_to_dict(ing) for ing in ingredients]

def read_one_ingredient(food_code: str):
    return ingredients_collection.find_one({"Food_Code": food_code})

def insert_one_ingredient(ingredient_data: dict):
    return ingredients_collection.insert_one(ingredient_data)
    
def update_one_ingredient(food_code: str, update_data: dict):
    return ingredients_collection.update_one({"Food_Code": food_code}, {"$set": update_data})

def delete_one_ingredient(food_code: str):
    return ingredients_collection.delete_one({"Food_Code": food_code})



meal_items_collection = db['Meal_Items']  # Collection name

def read_all_meal_items():
    meals = list(meal_items_collection.find())
    return [convert_to_dict(meal) for meal in meals]

def read_one_meal_item(meal_id: str):
    return meal_items_collection.find_one({"_id": meal_id})

def insert_one_meal_item(meal_data: dict):
    return meal_items_collection.insert_one(meal_data)

def update_one_meal_item(meal_id: str, update_data: dict):
    return meal_items_collection.update_one({"_id": meal_id}, {"$set": update_data})

def delete_one_meal_item(meal_id: str):
    return meal_items_collection.delete_one({"_id": meal_id})




def convert_to_dict(ingredient):
    """Converts MongoDB result to a dictionary format."""
    ingredient["_id"] = str(ingredient["_id"])
    return ingredient