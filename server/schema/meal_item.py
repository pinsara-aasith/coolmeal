from pydantic import BaseModel, Field
from typing import List, Optional

# Pydantic model for meal item
class MealItem(BaseModel):
    Id: str = Field(..., alias='_id')
    Meal_Id: int = Field(..., alias='Meal_Id')  # ID now matches the alias
    Name: str = Field(..., alias='Name')
    Meal_Ingredient_Ids: str = Field(..., alias='Meal_Ingredient_Ids')
    Meal_Ingredients_Names: str = Field(..., alias='Meal_Ingredients_Names')
    Meal_Ingredient_Quantities: str = Field(..., alias='Meal_Ingredient_Quantities')
    Category: str = Field(..., alias='Category')
    Description: str = Field(..., alias='Description')
    Supported_Main_Meals: Optional[str] = Field(None, alias='Supported_Main_Meals')  # NaN can be None
    Combinations_Supported: int = Field(..., alias='Combinations_Supported', allow_nan=True)
    Max_Combinations: Optional[int] = Field(..., alias='Max_Combinations', allow_nan=True)
    Min_Combinations: Optional[int] = Field(..., alias='Min_Combinations', allow_nan=True)
    Morning_Probability: Optional[float] = Field(..., alias='Morning_Probability', allow_nan=True)
    Lunch_Probability: Optional[float] = Field(..., alias='Lunch_Probability', allow_nan=True)
    Dinner_Probability: Optional[float] = Field(..., alias='Dinner_Probability', allow_nan=True)
