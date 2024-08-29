from fastapi import FastAPI
from createContext import createContext
from pydantic import BaseModel

app = FastAPI()

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
