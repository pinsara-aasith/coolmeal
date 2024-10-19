from pydantic import BaseModel, Field


# Pydantic model for data validation
class Meal(BaseModel):
    Main_Meal: str
    Side_Meal: str
    Breakfast_Probability: float
    Lunch_Probability: float
    Dinner_Probability: float
    Combined_Meal: int
    Complete_Meal: str
    Ingredients: str
    Quantities: str
    Meal_Ingredient_Ids: str
    Energy_Kcal: float
    Protein_g: float
    Total_fat_g: float
    Carbohydrates_g: float
    Total_Dietary_Fibre_g: float
    Vitamin_A_ug: float
    Vitamin_D_ug: float
    Vitamin_K_ug: float
    Vitamin_E_mg: float
    Calcium_mg: float
    Phosphorus_mg: float
    Magnesium_mg: float
    Sodium_mg: float
    Potassium_mg: float
