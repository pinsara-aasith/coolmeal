import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl


def recommend_nutrients(age_input, weight_input, height_input):
    # Define the fuzzy variables and their ranges
    age = ctrl.Antecedent(np.arange(0, 101, 1), "age")
    weight = ctrl.Antecedent(np.arange(30, 201, 1), "weight")
    height = ctrl.Antecedent(np.arange(100, 251, 1), "height")
    protein = ctrl.Consequent(np.arange(0, 201, 1), "protein")
    fat = ctrl.Consequent(np.arange(0, 101, 1), "fat")
    fiber = ctrl.Consequent(np.arange(0, 51, 1), "fiber")

    # Define membership functions for age
    age["young"] = fuzz.trapmf(age.universe, [0, 0, 20, 30])
    age["middle_aged"] = fuzz.trapmf(age.universe, [25, 35, 50, 60])
    age["senior"] = fuzz.trapmf(age.universe, [55, 65, 100, 100])

    # Define membership functions for weight
    weight["underweight"] = fuzz.trapmf(weight.universe, [30, 30, 50, 60])
    weight["normal"] = fuzz.trapmf(weight.universe, [55, 65, 75, 85])
    weight["overweight"] = fuzz.trapmf(weight.universe, [80, 90, 110, 120])
    weight["obese"] = fuzz.trapmf(weight.universe, [115, 130, 200, 200])

    # Define membership functions for height
    height["short"] = fuzz.trapmf(height.universe, [100, 100, 140, 155])
    height["average"] = fuzz.trapmf(height.universe, [150, 165, 175, 185])
    height["tall"] = fuzz.trapmf(height.universe, [180, 190, 250, 250])

    # Define membership functions for protein
    protein["low"] = fuzz.trapmf(protein.universe, [0, 0, 50, 75])
    protein["medium"] = fuzz.trapmf(protein.universe, [60, 80, 120, 150])
    protein["high"] = fuzz.trapmf(protein.universe, [140, 170, 200, 200])

    # Define membership functions for fat
    fat["low"] = fuzz.trapmf(fat.universe, [0, 0, 20, 30])
    fat["medium"] = fuzz.trapmf(fat.universe, [25, 35, 55, 70])
    fat["high"] = fuzz.trapmf(fat.universe, [65, 80, 100, 100])

    # Define membership functions for fiber
    fiber["low"] = fuzz.trapmf(fiber.universe, [0, 0, 10, 15])
    fiber["medium"] = fuzz.trapmf(fiber.universe, [12, 18, 25, 35])
    fiber["high"] = fuzz.trapmf(fiber.universe, [30, 40, 50, 50])

    # Define the fuzzy rules
    rule1 = ctrl.Rule(
        age["young"] & weight["normal"] & height["average"],
        (protein["medium"], fat["medium"], fiber["high"]),
    )
    rule2 = ctrl.Rule(
        age["middle_aged"] & weight["overweight"],
        (protein["low"], fat["low"], fiber["medium"]),
    )
    rule3 = ctrl.Rule(
        age["senior"] & weight["obese"] & height["short"],
        (protein["low"], fat["low"], fiber["high"]),
    )
    rule4 = ctrl.Rule(
        age["young"] & height["tall"], (protein["high"], fat["medium"], fiber["medium"])
    )
    # Default rule
    default_rule = ctrl.Rule(
        age["young"] | age["middle_aged"] | age["senior"],
        (protein["medium"], fat["medium"], fiber["medium"]),
    )

    # Create the control system and simulation
    food_ctrl = ctrl.ControlSystem([rule1, rule2, rule3, rule4, default_rule])
    food_simulation = ctrl.ControlSystemSimulation(food_ctrl)

    # Input the values into the simulation
    food_simulation.input["age"] = age_input
    food_simulation.input["weight"] = weight_input
    food_simulation.input["height"] = height_input

    try:
        # Perform the simulation
        food_simulation.compute()

        # Output the recommendations
        protein_recommended = food_simulation.output["protein"]
        fat_recommended = food_simulation.output["fat"]
        fiber_recommended = food_simulation.output["fiber"]

        return {
            "protein": round(protein_recommended, 2),
            "fat": round(fat_recommended, 2),
            "fiber": round(fiber_recommended, 2),
        }
    except ValueError as e:
        print("Error during computation: ", e)
        print("Using default values due to insufficient rule activation.")
        # Provide default values
        return {"protein": 100, "fat": 50, "fiber": 25}
