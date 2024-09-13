from pydantic import BaseModel


# Pydantic models for request body validation
class Item(BaseModel):
    id: str
    request: str
    response: str
