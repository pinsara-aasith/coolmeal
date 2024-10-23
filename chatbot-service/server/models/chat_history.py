from pydantic import BaseModel, Field
from typing import List, Optional
from createContext import summarize_chat


# Define a model for each chat entry (User/Assistant pair)
class ChatEntry(BaseModel):
    user: str
    assistant: str


# Define your Pydantic model for chat history
class ChatHistory(BaseModel):
    session_id: str
    data: List[str]  # List of chat entries
    title: str


# Function to convert the list into a list of dicts
def convert_to_chat_dict(chat_list):

    structured_chats = []

    print("Chat List : ", chat_list)

    for message in chat_list:

        isAppend = False
        if message.startswith("User:"):
            user_message = message.split("User:")[1].strip()  # Extract the User message

        elif message.startswith("Assistant:"):
            assistant_message = message.split("Assistant:")[1].strip()

            isAppend = True

        # Once we have a user and assistant message, add them to the structure
        if isAppend:

            structured_chats.append(
                {"User": user_message, "Assistant": assistant_message}
            )
            # Reset for the next pair
            user_message = None
            assistant_message = None

    chat_summery = summarize_chat(structured_chats)

    return structured_chats, chat_summery
