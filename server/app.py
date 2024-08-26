from fastapi import FastAPI
from model import train_knn_model
from model import predict_knn

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/prediction")
def read_prediction():
    input_data = [[1800, 154, 60, 23]]
    prediction = predict_knn("knn_model.pkl", input_data)
    print(prediction)
    return {"prediction": prediction.tolist()}

# Train the model and save it
model = train_knn_model()
print("model trained successfully --------------------- ")
# mention running port
print("app is running on port 8000")
