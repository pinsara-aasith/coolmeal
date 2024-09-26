from firebase_admin import credentials, firestore
import firebase_admin
from models.chat_template import ChatTemplate
from models.session_template import SessionTemplate
import asyncio

# Initialize fire base
cred = credentials.Certificate("./firebase_private_key.json")
firebase_admin.initialize_app(cred)
print("Initialize Firebase Admin SDK Successfully --------------------- ")

# Get Firestore client
db = firestore.client()

#  Collection for storing chat data
COLLECTION_NAME = "chat_store"
SESSION_COLLECTION_NAME = "session_store"


async def create_item(chat_template: ChatTemplate):
    print("chat_template -------------- ", chat_template)
    doc_ref = db.collection(COLLECTION_NAME).document(chat_template["id"])
    doc_ref.set(chat_template)
    print("Document written with ID: ", chat_template["id"])
    return {"message": "Item created successfully"}


async def create_session(session_template: SessionTemplate):
    print("userId -------------- ", session_template)
    doc_ref = db.collection(SESSION_COLLECTION_NAME).document(
        session_template["session_id"]
    )
    doc_ref.set(session_template)
    print("Document written with ID: ", session_template["session_id"])
    return {"message": "Item created successfully"}
