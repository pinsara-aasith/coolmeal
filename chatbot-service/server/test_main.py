import pytest
from fastapi.testclient import TestClient
from app import app

client = TestClient(app)


def test_check_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "Food chat bot Service"}


# def test_create_user_with_duplicate_id():
#     response = client.post("/users/", json={"id": 1, "name": "Doe", "age": 25})
#     assert response.status_code == 400
#     assert response.json() == {"detail": "User ID already exists"}

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
