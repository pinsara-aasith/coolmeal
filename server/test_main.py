import pytest
from fastapi.testclient import TestClient
from app import app

import uuid

client = TestClient(app)


def test_check_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "World"}


# Test case for the /prediction endpoint
def test_read_prediction():
    # Prepare the input data
    request_data = {
        "weight": 70.0,
        "height": 175.0,
        "age": 30,
        "gender": "male",
        "activity_level": "",
    }

    # Send a POST request to the /prediction endpoint
    response = client.post("/prediction", json=request_data)

    # Check if the response status code is 200 (OK)
    assert response.status_code == 200

    # Check if the response contains the expected structure
    response_data = response.json()
    assert "prediction" in response_data
    assert isinstance(response_data["prediction"], list)

    # You can add more assertions based on expected values in the response
    assert (
        len(response_data["prediction"]) > 0
    )  # At least one meal plan should be returned

    # Check the structure of the first meal plan
    meal_plan = response_data["prediction"][0]
    assert "Breakfast" in meal_plan
    assert "Lunch" in meal_plan
    assert "Dinner" in meal_plan
    assert "Combined Ingredients" in meal_plan
    assert "Total Energy (Kcal)" in meal_plan
    assert "Total Protein (g)" in meal_plan
    assert "Total Fat (g)" in meal_plan
    assert "Total Carbohydrates (g)" in meal_plan
    assert "Total Magnesium (mg)" in meal_plan
    assert "Total Sodium (mg)" in meal_plan
    assert "Total Potassium (mg)" in meal_plan
    assert "Total Saturated Fatty Acids (mg)" in meal_plan
    assert "Total Monounsaturated Fatty Acids (mg)" in meal_plan
    assert "Total Polyunsaturated Fatty Acids (mg)" in meal_plan
    assert "Total Free Sugar (g)" in meal_plan
    assert "Total Starch (g)" in meal_plan
