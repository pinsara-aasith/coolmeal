import asyncio
from fastapi import FastAPI, HTTPException
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

    # if sessio id is empty raise a error
    if session_id == "":
        raise HTTPException(status_code=404, detail="Session not found.")

    if session_id not in memory_helper.memory_store:
        memory_helper.memory_store[session_id] = [
            "'User: Hi ', Assistant: Hi! I am a specialized AI assistant for food data."
        ]

    memory_helper.memory_store[session_id] = memory_helper.update_memory_stack(
        question=request.query,
        response=response["result"],
        memory_stack=memory_helper.memory_store[session_id],
    )
    print("memory Updated Sucessfully --------------------- ")

    print("Memory Store : ", memory_helper.memory_store)
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


@app.post("/insertSessionData")
async def end_session(session_id: str):
    if session_id not in memory_helper.memory_store:
        raise HTTPException(status_code=404, detail="Session not found.")
    chat_history = memory_helper.memory_store[session_id]
    chat_history_data = {
        "session_id": session_id,
        "data": chat_history,
    }
    await mongodb_helper.insert_chat_history(chat_history_data)
    print("Chat history inserted successfully --------------------- ")
    return {"message": "Chat history inserted successfully."}


# create get endpoint for get all sessions coressponding to user id
@app.get("/gethistory")
async def get_history(user_id: str):
    print("get history function called *-** ")
    # get session ids --------------------------
    history = await mongodb_helper.getAllChatsForUser(user_id)
    return {"history": history}


# mention running port
print("app is running on port 8000")
