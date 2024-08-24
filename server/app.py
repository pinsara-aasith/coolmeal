from fastapi import FastAPI
from model import train_knn_model

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/prediction")
def read_prediction():
    input_data = [[1800, 154, 60, 23]]

    return {"prediction": "This is a prediction"}


# define data path
data_path = "/notebooks/daily_menus.csv"
# Train the model and save it
model = train_knn_model(data_path)
print("model trained successfully --------------------- ")
# mention running port
print("app is running on port 8000")
