from pydantic import BaseModel


class UserRequest(BaseModel):
    weight: float
    height: float
    age: int
    gender: str
    activity_level: str
    price: float
    diabetes_input: int
    pressure_input: int
    chol_input: int
