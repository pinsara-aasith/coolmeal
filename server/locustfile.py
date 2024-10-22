from locust import HttpUser, task, between
import random


class MealPlanUser(HttpUser):
    wait_time = between(1, 5)
    @task
    def post_prediction(self):
        # Randomized sample data for testing
        request_payload = {
            "age": random.randint(18, 70),
            "weight": random.uniform(50, 100),  # weight in kg
            "height": random.uniform(150, 200),  # height in cm
            "gender": random.choice(["male", "female"]),
            "activity_level": random.choice(
                [
                    "sedentary",
                    "lightly active",
                    "moderately active",
                    "very active",
                    "extra active",
                ]
            ),  # sample activity levels
        }

        # Post request to the FastAPI `/prediction` endpoint
        response = self.client.post("/prediction", json=request_payload)
        if response.status_code == 200:
            print("Prediction Success:", response.json())
        else:
            print("Prediction Failed:", response.status_code)
