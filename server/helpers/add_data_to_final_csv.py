import pandas as pd
import os


def add_meal_plan_to_csv(meal_plan_dict):
    # Define the path to the CSV file
    csv_file_path = "./FinalPermutations.csv"

    # Check if the CSV file exists
    if os.path.exists(csv_file_path):
        # Load the existing data into a DataFrame
        df = pd.read_csv(csv_file_path)

        # Create a DataFrame for the new meal plan
        new_meal_plan_df = pd.DataFrame([meal_plan_dict])

        # Concatenate the new meal plan to the existing DataFrame
        df = pd.concat([df, new_meal_plan_df], ignore_index=True)

        # Save the updated DataFrame back to the CSV file
        df.to_csv(csv_file_path, index=False)
    else:
        # If the file does not exist, create a new DataFrame and save it
        df = pd.DataFrame([meal_plan_dict])
        df.to_csv(csv_file_path, index=False)
