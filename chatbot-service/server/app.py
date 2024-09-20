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
    session_id: str


@app.get("/")
def read_root():
    return {"Hello": "Food chat bot Service"}


@app.post("/chat")
async def chat(request: ChatRequest):
    print("Session id : ", request.session_id)
    session_id = request.session_id
    response = chain.invoke(request.query)
    print(response)

    if session_id not in memory_helper.memory_store:
        memory_helper.memory_store[session_id] = [
            "Assistant: Hi! I am specialized AI assistant for food data."
        ]

    memory_helper.memory_store[session_id] = memory_helper.update_memory_stack(
        question=request.query,
        response=response["result"],
        memory_stack=memory_helper.memory_store[session_id],
    )
    print("memory Updated Sucessfully --------------------- ")

    print(memory_helper.memory_store)
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
    # add session to database with user id
    await mongodb_helper.create_session(session_template_data)
    return {"session_id": session_id}


# create get endpoint for get all sessions coressponding to user id
@app.get("/gethistory")
async def get_history(user_id: str):
    print("get history function called *-** ")
    # get all sessions coressponding to user id
    sessions = await mongodb_helper.find_session(user_id)
    return {"sessions": sessions}


# mention running port
print("app is running on port 8000")
