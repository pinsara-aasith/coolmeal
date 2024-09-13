from firebase_admin import credentials, firestore
import firebase_admin


# Initialize fire base
cred = credentials.Certificate(
    r"D:\DSE project\coolmeal\chatbot-service\server\firebase_private_key.json"
)
firebase_admin.initialize_app(cred)
print("Initialize Firebase Admin SDK Successfully --------------------- ")

# Get Firestore client
db = firestore.client()


async def create_item(item: Item):
    doc_ref = db.collection(COLLECTION_NAME).document(item.id)
    doc_ref.set(item.dict())
    return {"message": "Item created successfully"}
