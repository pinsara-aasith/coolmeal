import os
import requests
import pandas as pd
from fastapi import FastAPI, status
from fastapi.responses import JSONResponse
from schema.userRequest import UserRequest
from schema.meal_plan import MealPlan
from schema.meal import Meal
from fastapi import FastAPI, HTTPException
from real_fuzzy_logic import fuzzy_recommend_nutrients
from bmr import calculate_bmr, calculate_daily_calories
from model import train_knn_model
from model import predict_knn
from week_prediction import week_prediction
from admin_helper import add_new_meal_plan
from mongodbHelper import (
    get_meal_plan_by_index,
    serialize_meal_plan,
    get_all_meal_plans,
    get_meal_by_name,
    get_top_50_breakfast_meals,
    get_top_50_lunch_meals,
    get_top_50_dinner_meals,
    get_total_meal_plans_count,
    get_last_index,
    insert_new_meal_plan,
    insert_new_final_meal,
)

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
        csv_file_path = "./FinalPermutations.csv"
        print(f"Reading data from {csv_file_path}...")
        df = pd.read_csv(csv_file_path)

        df["index"] = range(len(df))
        df.to_csv(csv_file_path, index=False)
        print(f"Index column added and CSV file saved back to {csv_file_path}.")
    else:
        raise FileNotFoundError(
            f"Failed to download file from {s3_url}. HTTP status code: {response.status_code}"
        )


app = FastAPI()

df = pd.read_csv("./FinalPermutations.csv")
print("Data set read successfully --------------------- ")


model = train_knn_model()
print("Model trained successfully --------------------- ")


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


@app.get("/get-mealplan-index")
async def getMealPlanByIndex(index: int):
    try:
        meal_plan = await get_meal_plan_by_index(index)

        if not meal_plan:
            raise HTTPException(status_code=404, detail="Meal plan not found")

        serialized_meal_plan = serialize_meal_plan(meal_plan)

        return JSONResponse(
            status_code=200, content={"meal_plan": serialized_meal_plan}
        )

    except HTTPException as e:
        return JSONResponse(status_code=e.status_code, content={"detail": e.detail})

    except Exception as e:
        return JSONResponse(
            status_code=500, content={"detail": "An error occurred", "error": str(e)}
        )


@app.get("/mealplan")
async def get_meal_by_name_api(name: str):
    try:
        print("getting meal plan by name :::", name)
        meal = await get_meal_by_name(name)

        if not meal:
            raise HTTPException(status_code=404, detail="Meal plan not found")

        serialized_meal_plan = serialize_meal_plan(meal)

        return JSONResponse(
            status_code=200, content={"meal_plan": serialized_meal_plan}
        )

    except HTTPException as e:
        return JSONResponse(status_code=e.status_code, content={"detail": e.detail})

    except Exception as e:
        # Catch any other exceptions and return a 500 response
        return JSONResponse(
            status_code=500, content={"detail": "An error occurred", "error": str(e)}
        )


# Get Breakfast top 50 meals
@app.get("/meals/breakfast/top50")
async def get_top_50_breakfast_meals_api():
    try:
        meals = await get_top_50_breakfast_meals()

        if not meals:
            # If meals is None or empty, raise a 404 exception
            raise HTTPException(status_code=404, detail="Meals not found")

        # Serialize ObjectId to make it JSON serializable
        serialized_meals = [serialize_meal_plan(meal) for meal in meals]

        return JSONResponse(status_code=200, content={"meals": serialized_meals})

    except HTTPException as e:
        return JSONResponse(status_code=e.status_code, content={"detail": e.detail})

    except Exception as e:
        return JSONResponse(
            status_code=500, content={"detail": "An error occurred", "error": str(e)}
        )


# Get Lunch top 50 meals
@app.get("/meals/lunch/top50")
async def get_top_50_lunch_meals_api():
    try:
        meals = await get_top_50_lunch_meals()

        if not meals:
            raise HTTPException(status_code=404, detail="Meals not found")

        serialized_meals = [serialize_meal_plan(meal) for meal in meals]

        return JSONResponse(status_code=200, content={"meals": serialized_meals})

    except HTTPException as e:
        return JSONResponse(status_code=e.status_code, content={"detail": e.detail})

    except Exception as e:
        return JSONResponse(
            status_code=500, content={"detail": "An error occurred", "error": str(e)}
        )


@app.get("/meals/dinner/top50")
async def get_top_50_dinner_meals_api():
    try:
        meals = await get_top_50_dinner_meals()

        if not meals:
            raise HTTPException(status_code=404, detail="Meals not found")
        serialized_meals = [serialize_meal_plan(meal) for meal in meals]

        return JSONResponse(status_code=200, content={"meals": serialized_meals})

    except HTTPException as e:
        return JSONResponse(status_code=e.status_code, content={"detail": e.detail})

    except Exception as e:
        return JSONResponse(
            status_code=500, content={"detail": "An error occurred", "error": str(e)}
        )


# add get api end point for get all meal plans count
@app.get("/mealplans/count")
async def get_total_meal_plans_count_api():
    try:

        count = await get_total_meal_plans_count()
        return JSONResponse(status_code=200, content={"count": count})

    except Exception as e:
        return JSONResponse(
            status_code=500, content={"detail": "An error occurred", "error": str(e)}
        )


# create method for last meal plan index
@app.get("/mealplans/last")
async def get_last_meal_plan_api():
    try:
        last_index = await get_last_index()
        return JSONResponse(status_code=200, content={"last_index": last_index})

    except Exception as e:
        # Catch any exceptions and return a 500 response
        return JSONResponse(
            status_code=500, content={"detail": "An error occurred", "error": str(e)}
        )


@app.post("/mealplans", response_description="Add new meal plan", status_code=201)
async def create_meal_plan(meal_plan: MealPlan):
    try:
        meal_plan_dict = meal_plan.dict()
        print(meal_plan_dict)
        await add_new_meal_plan(meal_plan_dict)
        return JSONResponse(status_code=201, content={"data": "Success"})

    except ValueError as ve:
        # Handle specific ValueError exceptions
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(ve),  # Include the error message
        )
    except Exception as e:

        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="An error occurred while creating the meal plan.",  # General error message
        )


@app.post("/meals", response_description="Add new meal", status_code=201)
async def add_meal(meal: Meal):
    print(meal)

    try:
        meal_data = meal.dict()
        print(meal_data)
        new_meal = await insert_new_final_meal(meal_data)

        return {"status": "success", "data": str(new_meal["_id"])}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")


print("App is running on port 8000 ****************************************")
