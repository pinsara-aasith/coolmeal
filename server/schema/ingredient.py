from pydantic import BaseModel, Field
from typing import List, Optional

# Pydantic model for ingredient data
class Ingredient(BaseModel):
    Id: str = Field(..., alias='_id')
    Food_Code: str = Field(..., example="SLA001")
    Price_Code: str = Field(..., example="P1069")
    Food_Name: str = Field(..., alias="Food_Name", example="Barley (Hordeum vulgare)")
    Energy: float = Field(..., alias="Energy(Kcal)", example=313, coerce_numbers_to_str=True)
    Protein: float = Field(..., alias="Protein(g)", example=11.4, coerce_numbers_to_str=True)
    Total_fat: float = Field(..., alias="Total fat(g)", example=1.18, coerce_numbers_to_str=True)
    Carbohydrates: float = Field(..., alias="Carbohydrates(g)", example=60.9, coerce_numbers_to_str=True)
    Total_Dietary_Fibre: Optional[float] = Field(None, alias="Total Dietary Fibre(g)", coerce_numbers_to_str=True)
    Vitamin_A: Optional[float] = Field(None, alias="Vitamin A(µg)", coerce_numbers_to_str=True)
    Vitamin_D: Optional[float] = Field(None, alias="Vitamin D(µg)", coerce_numbers_to_str=True)
    Vitamin_K: Optional[float] = Field(None, alias="Vitamin K(µg)", coerce_numbers_to_str=True)
    Vitamin_E: Optional[float] = Field(None, alias="Vitamin E(mg)", coerce_numbers_to_str=True)
    Calcium: Optional[float] = Field(None, alias="Calcium(mg)", coerce_numbers_to_str=True)
    Phosphorus: Optional[float] = Field(None, alias="Phosphorus(mg)", coerce_numbers_to_str=True)
    Magnesium: Optional[float] = Field(None, alias="Magnesium(mg)", coerce_numbers_to_str=True)
    Sodium: Optional[float] = Field(None, alias="Sodium(mg)", coerce_numbers_to_str=True)
    Potassium: Optional[float] = Field(None, alias="Potassium(mg)", coerce_numbers_to_str=True)
    Saturated_Fatty_Acids: Optional[float] = Field(None, alias="Saturated Fatty Acids(mg)", coerce_numbers_to_str=True)
    Monounsaturated_Fatty_Acids: Optional[float] = Field(None, alias="Monounsaturated Fatty Acids(mg)", coerce_numbers_to_str=True)
    Polyunsaturated_Fatty_Acids: Optional[float] = Field(None, alias="Polyunsaturated Fatty Acids(mg)", coerce_numbers_to_str=True)
    Free_sugar: Optional[float] = Field(None, alias="Free sugar(g)", coerce_numbers_to_str=True)
    Starch: Optional[float] = Field(None, alias="Starch(g)", example=76.63, coerce_numbers_to_str=True)
