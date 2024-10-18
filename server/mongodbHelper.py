from pymongo import MongoClient
from pymongo.errors import ConnectionFailure, OperationFailure
from dotenv import load_dotenv


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
