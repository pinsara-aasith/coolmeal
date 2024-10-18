from pydantic import BaseModel, Field
from fastapi import FastAPI, HTTPException
from typing import List


# Pydantic model for data validation
class Meal(BaseModel):

    Main_Meal: str = Field(..., description="Main meal name")
    Side_Meal: str = Field(..., description="Side meal name")
    Breakfast_Probability: float = Field(
        ..., ge=0, description="Probability of being a breakfast meal"
    )
    Lunch_Probability: float = Field(
        ..., ge=0, description="Probability of being a lunch meal"
    )
    Dinner_Probability: float = Field(
        ..., ge=0, description="Probability of being a dinner meal"
    )
    Combined_Meal: int = Field(..., description="Indicator if meal is combined")
    Complete_Meal: str = Field(..., description="Description of the complete meal")
    Ingredients: str = Field(..., description="List of ingredients")
    Quantities: str = Field(..., description="Quantities of ingredients")
    Meal_Ingredient_Ids: str = Field(..., description="IDs of the ingredients")
    Energy_Kcal: float = Field(..., ge=0, description="Energy content in Kcal")
    Protein_g: float = Field(..., ge=0, description="Protein content in grams")
    Total_fat_g: float = Field(..., ge=0, description="Total fat content in grams")
    Carbohydrates_g: float = Field(
        ..., ge=0, description="Carbohydrates content in grams"
    )
    Total_Dietary_Fibre_g: float = Field(
        ..., ge=0, description="Dietary fiber content in grams"
    )
    Vitamin_A_ug: float = Field(..., ge=0, description="Vitamin A content in µg")
    Vitamin_D_ug: float = Field(..., ge=0, description="Vitamin D content in µg")
    Vitamin_K_ug: float = Field(..., ge=0, description="Vitamin K content in µg")
    Vitamin_E_mg: float = Field(..., ge=0, description="Vitamin E content in mg")
    Calcium_mg: float = Field(..., ge=0, description="Calcium content in mg")
    Phosphorus_mg: float = Field(..., ge=0, description="Phosphorus content in mg")
    Magnesium_mg: float = Field(..., ge=0, description="Magnesium content in mg")
    Sodium_mg: float = Field(..., ge=0, description="Sodium content in mg")
    Potassium_mg: float = Field(..., ge=0, description="Potassium content in mg")

    class Config:
        schema_extra = {
            "example": {
                "Main_Meal": "Kottu Roti",
                "Side_Meal": "Chicken Curry",
                "Breakfast_Probability": 1,
                "Lunch_Probability": 2.5,
                "Dinner_Probability": 8,
                "Combined_Meal": 1,
                "Complete_Meal": "Kottu Roti with Chicken Curry",
                "Ingredients": "Roti, carrot, leeks, Chicken, Coconut Oil, Chilli Powder, Coconut milk",
                "Quantities": "30, 20, 27.5, 70.0, 5, 2.5, 20.0, 5.0, 3.0",
                "Meal_Ingredient_Ids": "SLI019, SLB002, SLD055, SLH006, SLK004, SLK002, SLI005, SLK006, SLK007",
                "Energy_Kcal": 357.32,
                "Protein_g": 22.06,
                "Total_fat_g": 25.70,
                "Carbohydrates_g": 27.82,
                "Total_Dietary_Fibre_g": 8.25,
                "Vitamin_A_ug": 301.72,
                "Vitamin_D_ug": 4.16,
                "Vitamin_K_ug": 45.10,
                "Vitamin_E_mg": 1.52,
                "Calcium_mg": 90.11,
                "Phosphorus_mg": 242.7,
                "Magnesium_mg": 68.42,
                "Sodium_mg": 41.99,
                "Potassium_mg": 584.06,
            }
        }
