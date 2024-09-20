import asyncio
from fastapi import FastAPI
from createContext import createContext
from pydantic import BaseModel
import mongodb_helper
import uuid
import memory_helper
from models.session_response import SessionResponse


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
        "id": "1225",
        "request": request.query,
        "response": response["result"],
    }
    print("storage function called *-** ")
    # Run the Firebase operation asynchronously without blocking the response
    # asyncio.create_task(
    #     firebase_db_helper.create_item(chat_template=chat_template_data)
    # )
    return {"response": response["result"]}


@app.post("/getSession", response_model=SessionResponse)
async def get_session(user_id: str):
    session_id = str(uuid.uuid4())
    memory_helper.memory_store[session_id] = memory_helper.clear_memory_stack()
    session_template_data = {
        "user_id": user_id,
        "session_id": session_id,
    }
    print("storage function called *-** ")

    return {"session_id": session_id}


# mention running port
print("app is running on port 8000")
