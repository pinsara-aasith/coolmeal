from fastapi import FastAPI
from createContext import createContext

app = FastAPI()

# create LLM chain ()
chain = createContext()
print("Load Chain Successfully --------------------- ")


@app.get("/")
def read_root():
    return {"Hello": "Food chat bot Service"}


@app.post("/chat")
def chat(query: str):
    response = chain.invoke(query)
    return {"response": response}


# mention running port
print("app is running on port 8000")
