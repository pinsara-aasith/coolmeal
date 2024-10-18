def add_new_meal_plan(meal_plan):
    try:
        result = meal_plan_collection.insert_one(meal_plan)
        print(f"Meal plan inserted with ID: {result}")
    except OperationFailure as e:
        print(f"Insert operation failed: {e}")
    return result
