from model import predict_knn
import pandas as pd


# Function to calculate differences
def calculate_difference(net_result, output):
    differences = {}
    differences["protein"] = net_result["protein"] - output["Total Protein(g)"]
    differences["fat"] = net_result["fat"] - output["Total fat(g)"]
    differences["carbohydrates"] = (
        net_result["carbohydrates"] - output["Total Carbohydrates(g)"]
    )
    differences["magnesium"] = net_result["magnesium"] - output["Total Magnesium(mg)"]
    differences["sodium"] = net_result["sodium"] - output["Total Sodium(mg)"]
    differences["potassium"] = net_result["potassium"] - output["Total Potassium(mg)"]
    differences["saturated_fats"] = (
        net_result["saturated_fats"] - output["Total Saturated Fatty Acids(mg)"]
    )
    differences["monounsaturated_fats"] = (
        net_result["monounsaturated_fats"]
        - output["Total Monounsaturated Fatty Acids(mg)"]
    )
    differences["polyunsaturated_fats"] = (
        net_result["polyunsaturated_fats"]
        - output["Total Polyunsaturated Fatty Acids(mg)"]
    )
    differences["free_sugar"] = net_result["free_sugar"] - output["Total Free sugar(g)"]
    differences["starch"] = net_result["starch"] - output["Total Starch(g)"]

    return differences


def calculateNewNetResult(net_result, difference):
    # new net_result = net_result + difference
    new_net_result = {}
    # use loop
    for key in net_result:
        new_net_result[key] = net_result[key] + difference[key]
    return new_net_result


def week_prediction(df, price, net_result, total_calories, output, meal_plans):
    selected_meal_indices = []
    selected_meal_indices.append(output["index"])

    for i in range(6):
        differences = calculate_difference(net_result, output)
        net_result = calculateNewNetResult(net_result, differences)

        total_calories = total_calories + (
            total_calories - output["Total Energy(Kcal)"]
        )

        input_data = [
            [
                price,
                total_calories,
                net_result["protein"],
                net_result["fat"],
                net_result["carbohydrates"],
                net_result["magnesium"],
                net_result["sodium"],
                net_result["potassium"],
                net_result["saturated_fats"],
                net_result["monounsaturated_fats"],
                net_result["polyunsaturated_fats"],
                net_result["free_sugar"],
                net_result["starch"],
            ]
        ]

        prediction = predict_knn("ml_model.pkl", input_data)

        print("Prediction -----------", prediction)

        # Try to find a meal that has not been selected yet
        selected = False
        for pred_index in prediction[0]:
            if pred_index not in selected_meal_indices:
                output = df.iloc[pred_index].to_dict()
                selected_meal_indices.append(pred_index)
                selected = True
                break

        # If all meals in prediction are duplicates, pick a random unselected meal
        if not selected:
            output = df.iloc[prediction[0][0]].to_dict()

        meal_plans.append(output)

    return meal_plans
