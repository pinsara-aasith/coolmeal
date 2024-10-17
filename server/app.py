import os
import requests
import pandas as pd
from fastapi import FastAPI
from fastapi.responses import JSONResponse
from schema.userRequest import UserRequest
from real_fuzzy_logic import fuzzy_recommend_nutrients
from bmr import calculate_bmr, calculate_daily_calories
from model import train_knn_model
from model import predict_knn
from week_prediction import week_prediction

if not os.path.exists("./FinalPermutations.csv"):
    s3_url = "https://coolmeal.s3.amazonaws.com/FinalPermutations.csv"
    print(f"File not found at ./FinalPermutations.csv. Downloading from S3...")
    response = requests.get(s3_url)

    if response.status_code == 200:
        with open("./FinalPermutations.csv", "wb") as f:
            f.write(response.content)
        print(
            f"File downloaded successfully from S3 and saved to ./FinalPermutations.csv."
        )
    else:
        raise FileNotFoundError(
            f"Failed to download file from {s3_url}. HTTP status code: {response.status_code}"
        )


app = FastAPI()

df = pd.read_csv("./FinalPermutations.csv")
print("Data set read successfully --------------------- ")


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/prediction")
def read_prediction(request: UserRequest):
    meal_plans = []
    nut_result = fuzzy_recommend_nutrients(request.age, request.weight, request.height)
    tot_bmr = calculate_bmr(request.weight, request.height, request.age, request.gender)
    tot_kalories = calculate_daily_calories(tot_bmr, request.activity_level)

    input_data = [
        [
            float(request.price),
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
    prediction = predict_knn("ml_model.pkl", input_data)
    print(prediction)
    output = df.iloc[prediction[0]].to_dict(orient="records")

    print(output[0])
    meal_plans.append(output[0])

    week_plan = week_prediction(
        df, float(request.price), nut_result, tot_kalories, output[0], meal_plans
    )
    return JSONResponse(status_code=200, content={"prediction": week_plan})


model = train_knn_model()
print("Model trained successfully --------------------- ")
print("App is running on port 8000")
