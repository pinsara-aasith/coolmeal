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


def test_read_prediction_check_all_attr():
    # Prepare the input data
    request_data = {
        "weight": 70.0,
        "height": 175.0,
        "age": 30,
        "gender": "male",
        "activity_level": "moderate",  # Assuming valid activity level
    }

    # Send a POST request to the /prediction endpoint
    response = client.post("/prediction", json=request_data)

    # Check if the response status code is 200 (OK)
    assert response.status_code == 200

    # Check if the response contains the expected structure
    response_data = response.json()
    assert "prediction" in response_data
    assert isinstance(response_data["prediction"], list)

    # Check that the length of the prediction list is 7 (for 7 days)
    assert len(response_data["prediction"]) == 7

    # Check that each meal plan has the required attributes
    required_attributes = [
        "Breakfast",
        "Lunch",
        "Dinner",
        "Combined Ingredients",
        "Total Energy (Kcal)",
        "Total Protein (g)",
        "Total Fat (g)",
        "Total Carbohydrates (g)",
        "Total Magnesium (mg)",
        "Total Sodium (mg)",
        "Total Potassium (mg)",
        "Total Saturated Fatty Acids (mg)",
        "Total Monounsaturated Fatty Acids (mg)",
        "Total Polyunsaturated Fatty Acids (mg)",
        "Total Free Sugar (g)",
        "Total Starch (g)",
    ]

    for meal_plan in response_data["prediction"]:
        for attr in required_attributes:
            assert attr in meal_plan


def test_missing_input_data():
    # Prepare invalid input data with missing fields (e.g., missing 'height')
    request_data = {
        "weight": 70.0,
        "age": 30,
        "gender": "male",
        "activity_level": "moderate",
    }

    # Send a POST request to the /prediction endpoint
    response = client.post("/prediction", json=request_data)

    # Check if the response status code is 422 (Unprocessable Entity) due to missing fields
    assert response.status_code == 422

    # Check if the response contains the correct error message
    response_data = response.json()
    assert "detail" in response_data
    assert isinstance(response_data["detail"], list)


def test_invalid_input_data():
    # Prepare invalid input data with incorrect types (e.g., 'weight' as a string)
    request_data = {
        "weight": "invalid_weight",  # Should be a float, but given as a string
        "height": 175.0,
        "age": 30,
        "gender": "male",
        "activity_level": "moderate",
    }

    # Send a POST request to the /prediction endpoint
    response = client.post("/prediction", json=request_data)

    # Check if the response status code is 422 (Unprocessable Entity) due to invalid data types
    assert response.status_code == 422

    # Check if the response contains the correct error message
    response_data = response.json()
    assert "detail" in response_data
    assert isinstance(response_data["detail"], list)
