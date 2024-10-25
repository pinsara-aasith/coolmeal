from pydantic import BaseModel


class MealName(BaseModel):
    name: str
