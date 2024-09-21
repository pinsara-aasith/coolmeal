import pytest
from fastapi.testclient import TestClient
from app import app
import uuid

client = TestClient(app)


def test_check_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "Food chat bot Service"}


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
@pytest.mark.asyncio
async def test_get_session():
    user_id = "test_user"  # Replace with a valid user ID for testing

    # Make a POST request to the /getSession endpoint with user_id in the query string
    response = await client.post("/getSession", params={"user_id": user_id})

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


# def test_list_users():
#     response = client.get("/users/")
#     assert response.status_code == 200
#     assert len(response.json()) == 1

# def test_get_user():
#     response = client.get("/users/1")
#     assert response.status_code == 200
#     assert response.json() == {"id": 1, "name": "John", "age": 30}

# def test_get_non_existing_user():
#     response = client.get("/users/999")
#     assert response.status_code == 404
#     assert response.json() == {"detail": "User not found"}

# def test_update_user():
#     response = client.put("/users/1", json={"id": 1, "name": "Jane", "age": 32})
#     assert response.status_code == 200
#     assert response.json() == {"id": 1, "name": "Jane", "age": 32}

# def test_delete_user():
#     response = client.delete("/users/1")
#     assert response.status_code == 200
#     assert response.json() == {"id": 1, "name": "Jane", "age": 32}

# def test_delete_non_existing_user():
#     response = client.delete("/users/999")
#     assert response.status_code == 404
#     assert response.json() == {"detail": "User not found"}
