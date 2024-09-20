from pymongo import MongoClient
from pymongo.errors import ConnectionFailure, OperationFailure
from models.session_template import SessionTemplate
from dotenv import load_dotenv


import os

load_dotenv()
# Replace the following with your MongoDB Atlas connection string
MONGODB_URI = os.getenv("MONGODB_URI")

# Initialize the MongoDB client
try:
    client = MongoClient(MONGODB_URI)
    print("Connected to MongoDB Atlas ---------------------------- ")
except ConnectionFailure as e:
    print(f"Could not connect to MongoDB: {e}")


# Select the database and collection
db = client["cool-meal"]
session_collection = db["session_collection"]
history_collection = db["history_collection"]

print("Connected to the database and collection ---------------------------- ")


# Create (Insert)
async def create_session(session_template: SessionTemplate):
    print("session_template -------------- ", session_template)
    try:
        result = session_collection.insert_one(
            session_template
        )  # Convert Pydantic model to dict
        print(f"User inserted with ID: {result}")
    except OperationFailure as e:
        print(f"Insert operation failed: {e}")


# Read (Find)
async def find_session(user_id: str):
    print("user_id -------------- ", user_id)
    session_id_list = []
    try:
        result = session_collection.find({"user_id": user_id})
        print(f"Session found: {result}")
        for document in result.to_list(
            length=None
        ):  # length=None retrieves all documents
            print(f"Session found: {document}")
            session_id_list.append(document["session_id"])
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
    return session_id_list


# Get user for given session_id
async def get_user(session_id: str):
    print("session_id -------------- ", session_id)
    try:
        result = session_collection.find_one({"session_id": session_id})
        print(f"User found: {result}")
    except OperationFailure as e:
        print(f"Find operation failed: {e}")
