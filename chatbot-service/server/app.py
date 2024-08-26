from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "Food chat bot Service"}


# mention running port
print("app is running on port 8000")
