def convert_meal_plan_dict(original_dict):
    # Conversion logic
    converted_dict = {
        "Breakfast": original_dict["Breakfast"],
        "Lunch": original_dict["Lunch"],
        "Dinner": original_dict["Dinner"],
        "Price": original_dict["Price"],
        "Total Energy(Kcal)": original_dict["Total_Energy_Kcal"],
        "Total Protein(g)": original_dict["Total_Protein_g"],
        "Total Total fat(g)": original_dict["Total_Fat_g"],
        "Total Carbohydrates(g)": original_dict["Total_Carbohydrates_g"],
        "Total Magnesium(mg)": original_dict["Total_Magnesium_mg"],
        "Total Sodium(mg)": original_dict["Total_Sodium_mg"],
        "Total Potassium(mg)": original_dict["Total_Potassium_mg"],
        "Total Saturated Fatty Acids(mg)": original_dict[
            "Total_Saturated_Fatty_Acids_mg"
        ],
        "Total Monounsaturated Fatty Acids(mg)": original_dict[
            "Total_Monounsaturated_Fatty_Acids_mg"
        ],
        "Total Polyunsaturated Fatty Acids(mg)": original_dict[
            "Total_Polyunsaturated_Fatty_Acids_mg"
        ],
        "Total Free sugar(g)": original_dict["Total_Free_Sugar_g"],
        "Total Starch(g)": original_dict["Total_Starch_g"],
        "index": original_dict["index"],
    }
    return converted_dict
