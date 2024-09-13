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
def chat(request: ChatRequest):
    response = chain.invoke(request.query)
    # print("response", )
    return {"response": response}


# mention running port
print("app is running on port 8000")
