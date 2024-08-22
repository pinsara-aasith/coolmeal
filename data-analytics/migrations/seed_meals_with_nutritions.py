import pandas as pd

# Read the meals and nutrition data from CSV files
meals_df = pd.read_csv('meals.csv')
nutrition_df = pd.read_csv('nutrition.csv')

# Prepare a dictionary to map ingredient names to their nutritional values
nutrition_dict = {}
for index, row in nutrition_df.iterrows():
    nutrition_dict[row['Food Name']] = {
        'Energy': row['Energy (Kcal)'],
        'Protein': row['Protein(g)'],
        'Total fat': row['Total fat(g)'],
        'Carbohydrates': row['Carbohydrates(g)'],
        'Total Dietary Fibre': row['Total Dietary Fibre(g)'],
        'Vitamin A': row['Vitamin A(µg)'],
        'Vitamin D': row['Vitamin D(µg)'],
        'Vitamin K': row['Viatmin K(µg)'],
        'Vitamin E': row['Vitamin E(mg)'],
        'Calcium': row['Calcium(mg)'],
        'Phosphorus': row['Phosphorus(mg)'],
        'Magnesium': row['Magnesium(mg)'],
        'Sodium': row['Sodium(mg)'],
        'Potassium': row['Potassium(mg)'],
        'Saturated Fatty Acids': row['Saturated Fatty Acids(mg)'],
        'Monounsaturated Fatty Acids': row['Monounsaturated Fatty Acids(mg)'],
        'Polyunsaturated Fatty Acids': row['Polyunsaturated Fatty Acids(mg)'],
        'Free sugar': row['Free sugar(g)'],
        'Starch': row['Starch(g)']
    }

# Initialize empty lists to store calculated nutrition values
calculated_nutrition = []

# Calculate nutrition per meal
for index, row in meals_df.iterrows():
    ingredients = row['Meal_Ingredients'].split(', ')
    quantities = list(map(float, row['Meal_Ingredient_Quantities'].split(',')))

    meal_nutrition = {
        'Energy': 0,
        'Protein': 0,
        'Total fat': 0,
        'Carbohydrates': 0,
        'Total Dietary Fibre': 0,
        'Vitamin A': 0,
        'Vitamin D': 0,
        'Vitamin K': 0,
        'Vitamin E': 0,
        'Calcium': 0,
        'Phosphorus': 0,
        'Magnesium': 0,
        'Sodium': 0,
        'Potassium': 0,
        'Saturated Fatty Acids': 0,
        'Monounsaturated Fatty Acids': 0,
        'Polyunsaturated Fatty Acids': 0,
        'Free sugar': 0,
        'Starch': 0
    }

    for i, ingredient in enumerate(ingredients):
        if ingredient in nutrition_dict:
            quantity = quantities[i] / 100.0  # Convert quantity to per 100g
            for key in meal_nutrition.keys():
                meal_nutrition[key] += nutrition_dict[ingredient][key] * quantity

    calculated_nutrition.append(meal_nutrition)

# Add calculated nutrition to the meals_df
for key in calculated_nutrition[0].keys():
    meals_df[key] = [nutrition[key] for nutrition in calculated_nutrition]