import asyncio
from fastapi import FastAPI
from createContext import createContext
from pydantic import BaseModel
import firebase_db_helper


app = FastAPI()


import firebase_admin
from firebase_admin import credentials, firestore


# Path to your Firebase configuration JSON file
firebase_config_path = "./firebase_private_key.json"

app = FastAPI()


# print("Initialize Firebase Admin SDK Successfully --------------------- ")

# create LLM chain ()
chain = createContext()
print("Load Chain Successfully --------------------- ")


class ChatRequest(BaseModel):
    query: str


@app.get("/")
def read_root():
    return {"Hello": "Food chat bot Service"}


@app.post("/chat")
async def chat(request: ChatRequest):
    response = chain.invoke(request.query)
    print(response)
    chat_template_data = {
        "id": "123",
        "request": request.query,
        "response": response["result"],
    }
    print("storage function called *-** ")
    # Run the Firebase operation asynchronously without blocking the response
    asyncio.create_task(
        firebase_db_helper.create_item(chat_template=chat_template_data)
    )
    return {"response": response["result"]}


# mention running port
print("app is running on port 8000")
