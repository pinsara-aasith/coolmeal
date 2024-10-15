import pytest
from fastapi.testclient import TestClient
from app import app
import memory_helper
import uuid

client = TestClient(app)


def test_check_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "Food chat bot Service"}


# Test chat
def test_chat():
    response = client.post("/chat", json={"query": "Hi", "session_id": "123"})

    # Assert that the response status code is 200
    assert response.status_code == 200

    # Get the response JSON
    response_data = response.json()

    # Assert that "response" is in the JSON response
    assert "response" in response_data

    # Check if the "response" field is a string
    assert isinstance(response_data["response"], str)


# test get session
def test_get_session():
    user_id = "test_user"  # Replace with a valid user ID for testing

    # Make a POST request to the /getSession endpoint with user_id in the query string
    response = client.post("/getSession", params={"user_id": user_id})

    # Assert that the response status code is 200 (OK)
    assert response.status_code == 200

    # Assert that the response contains a session_id
    response_data = response.json()
    assert "session_id" in response_data

    # Optionally, verify that the session_id is a valid UUID
    try:
        uuid_obj = uuid.UUID(response_data["session_id"])
        assert str(uuid_obj) == response_data["session_id"]
    except ValueError:
        pytest.fail("session_id is not a valid UUID")


# test insert session data
def test_insert_session_data():
    user_id = "test_user"
    # First, create a session to get a session_id
    response = client.post("/getSession", params={"user_id": user_id})
    session_id = response.json()["session_id"]

    # Now, insert session data
    response = client.post(f"/insertSessionData?session_id={session_id}")

    assert response.status_code == 200
    data = response.json()
    print("Data : ", data)
    assert data["message"] == "Chat history inserted successfully."


def test_insert_session_data_not_found():
    response = client.post("/insertSessionData?session_id=invalid_session_id")

    assert response.status_code == 404
    assert response.json() == {"detail": "Session not found."}


def test_get_history():
    user_id = "test_user"

    # Now, call the endpoint to get history
    response = client.get(f"/gethistory?user_id={user_id}")

    assert response.status_code == 200
    data = response.json()
    print("Data : ", data)
    assert "history" in data
    # check history is list
    assert isinstance(data["history"], list)
