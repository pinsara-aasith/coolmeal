from pydantic import BaseModel, Field


# Pydantic model for data validation
class MealPlan(BaseModel):

    Breakfast: str = Field(..., description="Meal for breakfast")
    Lunch: str = Field(..., description="Meal for lunch")
    Dinner: str = Field(..., description="Meal for dinner")
    Price: float = Field(..., ge=0, description="Price of the meal plan")
    Total_Energy_Kcal: float = Field(
        ..., ge=0, alias="Total Energy(Kcal)", description="Total energy in kcal"
    )
    Total_Protein_g: float = Field(
        ..., ge=0, alias="Total Protein(g)", description="Total protein in grams"
    )
    Total_Fat_g: float = Field(
        ..., ge=0, alias="Total fat(g)", description="Total fat in grams"
    )
    Total_Carbohydrates_g: float = Field(
        ...,
        ge=0,
        alias="Total Carbohydrates(g)",
        description="Total carbohydrates in grams",
    )
    Total_Magnesium_mg: float = Field(
        ..., ge=0, alias="Total Magnesium(mg)", description="Total magnesium in mg"
    )
    Total_Sodium_mg: float = Field(
        ..., ge=0, alias="Total Sodium(mg)", description="Total sodium in mg"
    )
    Total_Potassium_mg: float = Field(
        ..., ge=0, alias="Total Potassium(mg)", description="Total potassium in mg"
    )
    Total_Saturated_Fatty_Acids_mg: float = Field(
        ...,
        ge=0,
        alias="Total Saturated Fatty Acids(mg)",
        description="Total saturated fatty acids in mg",
    )
    Total_Monounsaturated_Fatty_Acids_mg: float = Field(
        ...,
        ge=0,
        alias="Total Monounsaturated Fatty Acids(mg)",
        description="Total monounsaturated fatty acids in mg",
    )
    Total_Polyunsaturated_Fatty_Acids_mg: float = Field(
        ...,
        ge=0,
        alias="Total Polyunsaturated Fatty Acids(mg)",
        description="Total polyunsaturated fatty acids in mg",
    )
    Total_Free_Sugar_g: float = Field(
        ..., ge=0, alias="Total Free sugar(g)", description="Total free sugar in grams"
    )
    Total_Starch_g: float = Field(
        ..., ge=0, alias="Total Starch(g)", description="Total starch in grams"
    )
    index: int = Field(None, description="Index of the meal plan")

    class Config:
        allow_population_by_field_name = True
        schema_extra = {
            "example": {
                "Breakfast": "Red Rice with Fish Curry, Tapioca Chips, Batu Moju",
                "Lunch": "Red Rice with Banana Blossom Curry, Green Gram Curry, Fenugreek Curry",
                "Dinner": "Vegetable Kottu with Devilled Fish",
                "Price": 792.3,
                "Total Energy(Kcal)": 1482.37,
                "Total Protein(g)": 73.5357,
                "Total fat(g)": 83.1566,
                "Total Carbohydrates(g)": 175.9371,
                "Total Magnesium(mg)": 478.5,
                "Total Sodium(mg)": 128.367,
                "Total Potassium(mg)": 3346.98,
                "Total Saturated Fatty Acids(mg)": 37105.9815,
                "Total Monounsaturated Fatty Acids(mg)": 6314.2741,
                "Total Polyunsaturated Fatty Acids(mg)": 5152.7615,
                "Total Free sugar(g)": 11.7442,
                "Total Starch(g)": 151.1037,
                "index": 2,
            }
        }
