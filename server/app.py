from fastapi import FastAPI
from model import train_knn_model
from model import predict_knn
from fastapi.responses import JSONResponse
from schema.userRequest import UserRequest
from real_fuzzy_logic import fuzzy_recommend_nutrients
from bmr import calculate_bmr, calculate_daily_calories
import pandas as pd

app = FastAPI()

# To get the actual rows from the dataframe corresponding to the predictions:
df = pd.read_csv("./final_meal_combinations_dataset.csv")
print("Data set read successfully --------------------- ")


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/prediction")
def read_prediction(request: UserRequest):
    nut_result = fuzzy_recommend_nutrients(request.age, request.weight, request.height)
    tot_bmr = calculate_bmr(request.weight, request.height, request.age, request.gender)
    tot_kalories = calculate_daily_calories(tot_bmr, request.activity_level)
    input_data = [
        [
            tot_kalories,
            nut_result["protein"],
            nut_result["fat"],
            nut_result["carbohydrates"],
            nut_result["magnesium"],
            nut_result["sodium"],
            nut_result["potassium"],
            nut_result["saturated_fats"],
            nut_result["monounsaturated_fats"],
            nut_result["polyunsaturated_fats"],
            nut_result["free_sugar"],
            nut_result["starch"],
        ]
    ]
    print(input_data)
    prediction = predict_knn("knn_model.pkl", input_data)
    print(prediction)
    output = df.iloc[prediction[0]].to_dict(orient="records")
    return JSONResponse(status_code=200, content={"prediction": output})


# Train the model and save it
model = train_knn_model()
print("model trained successfully --------------------- ")
# mention running port
print("app is running on port 8000")
