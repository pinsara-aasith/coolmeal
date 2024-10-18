from pydantic import BaseModel, Field


# Pydantic model for data validation
class MealPlan(BaseModel):
    Breakfast: str = Field(..., description="Meal for breakfast")
    Lunch: str = Field(..., description="Meal for lunch")
    Dinner: str = Field(..., description="Meal for dinner")
    Price: float = Field(..., ge=0, description="Price of the meal plan")
    Total_Energy_Kcal: float = Field(..., ge=0, description="Total energy in kcal")
    Total_Protein_g: float = Field(..., ge=0, description="Total protein in grams")
    Total_Fat_g: float = Field(..., ge=0, description="Total fat in grams")
    Total_Carbohydrates_g: float = Field(
        ..., ge=0, description="Total carbohydrates in grams"
    )
    Total_Magnesium_mg: float = Field(..., ge=0, description="Total magnesium in mg")
    Total_Sodium_mg: float = Field(..., ge=0, description="Total sodium in mg")
    Total_Potassium_mg: float = Field(..., ge=0, description="Total potassium in mg")
    Total_Saturated_Fatty_Acids_mg: float = Field(
        ..., ge=0, description="Total saturated fatty acids in mg"
    )
    Total_Monounsaturated_Fatty_Acids_mg: float = Field(
        ..., ge=0, description="Total monounsaturated fatty acids in mg"
    )
    Total_Polyunsaturated_Fatty_Acids_mg: float = Field(
        ..., ge=0, description="Total polyunsaturated fatty acids in mg"
    )
    Total_Free_Sugar_g: float = Field(
        ..., ge=0, description="Total free sugar in grams"
    )
    Total_Starch_g: float = Field(..., ge=0, description="Total starch in grams")
    index: int = Field(None, description="Index of the meal plan")

    class Config:
        schema_extra = {
            "example": {
                "Breakfast": "Red Rice with Fish Curry, Tapioca Chips, Batu Moju",
                "Lunch": "Red Rice with Banana Blossom Curry, Green Gram Curry, Fenugreek Curry",
                "Dinner": "Vegetable Kottu with Devilled Fish",
                "Price": 792.3,
                "Total_Energy_Kcal": 1482.37,
                "Total_Protein_g": 73.5357,
                "Total_Fat_g": 83.1566,
                "Total_Carbohydrates_g": 175.9371,
                "Total_Magnesium_mg": 478.5,
                "Total_Sodium_mg": 128.367,
                "Total_Potassium_mg": 3346.98,
                "Total_Saturated_Fatty_Acids_mg": 37105.9815,
                "Total_Monounsaturated_Fatty_Acids_mg": 6314.2741,
                "Total_Polyunsaturated_Fatty_Acids_mg": 5152.7615,
                "Total_Free_Sugar_g": 11.7442,
                "Total_Starch_g": 151.1037,
                "index": 100,
            }
        }
