from helpers.convert_dict import convert_meal_plan_dict
from helpers.add_data_to_final_csv import add_meal_plan_to_csv
from model import train_knn_model
from mongodbHelper import insert_new_meal_plan


async def add_new_meal_plan(meal_plan):
    meal_plan_dict = convert_meal_plan_dict(meal_plan)
    print("meal_plan_dict -------------- ", meal_plan_dict)
    # Add the meal plan to the CSV file
    add_meal_plan_to_csv(meal_plan_dict)
    print("Meal plan added to CSV file -------------- ")

    # Retrain Model --------------------------
    model = train_knn_model()
    print("Model retrained -------------- ///////////////////")
    await insert_new_meal_plan(meal_plan_dict)
    print("Meal plan added to MongoDB -------------- ")


# Add whole meal_plan
# Add meal seperate
