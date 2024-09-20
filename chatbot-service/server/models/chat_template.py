from pydantic import BaseModel


# Pydantic models for request body validation
class ChatTemplate(BaseModel):
    id: str
    request: str
    response: str
