from fastapi import FastAPI
from model import train_knn_model
from model import predict_knn
from fastapi.responses import JSONResponse
import pandas as pd

app = FastAPI()

# To get the actual rows from the dataframe corresponding to the predictions:
df = pd.read_csv("../notebooks/daily_menus.csv")


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/prediction")
def read_prediction():
    input_data = [[1800, 154, 60, 23]]
    prediction = predict_knn("knn_model.pkl", input_data)
    print(prediction)
    output = df.iloc[prediction[0]].to_dict()
    return JSONResponse(status_code=200, content={"prediction": output})


# define data path

# Train the model and save it
model = train_knn_model()
print("model trained successfully --------------------- ")
# mention running port
print("app is running on port 8000")
