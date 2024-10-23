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
    print("chat_list", chat_list)
    chat_history = []

    for i in range(0, len(chat_list), 2):  # Step 2 to get pairs of User and Assistant
        user_message = chat_list[i + 1] if i + 1 < len(chat_list) else None
        assistant_message = chat_list[i]

        print("user_message", user_message)
        print("assistant_message", assistant_message)

        if user_message:
            # Extract 'User' and 'Assistant' messages
            user_msg_content = user_message.split(": ", 1)[
                1
            ]  # Split at the first colon to separate the message
        if assistant_message:
            assistant_msg_content = assistant_message.split(": ", 1)[1]

    # Append a dict with 'User' and 'Assistant' as keys
    chat_history.append({"User": user_msg_content, "Assistant": assistant_msg_content})
    chat_summery = summarize_chat(chat_history)

    return chat_history, chat_summery
