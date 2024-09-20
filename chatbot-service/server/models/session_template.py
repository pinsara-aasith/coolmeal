from pydantic import BaseModel


class SessionTemplate(BaseModel):
    user_id: str
