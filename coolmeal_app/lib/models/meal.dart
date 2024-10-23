class Meal {
  final String id;
  final String mainMeal;
  final String sideMeal;
  final String completeMeal;
  final String? ingredients;
  final String? quantities;
  final String? mealIngredientIds;
  final double? energyKcal;
  final double? proteinG;
  final double? totalFatG;
  final double? carbohydratesG;
  final double? totalDietaryFibreG;
  final double? vitaminAUg;
  final double? vitaminDUg;
  final double? vitaminEUg;
  final double? calciumMg;
  final double? phosphorusMg;
  final double? magnesiumMg;
  final double? sodiumMg;
  final double? potassiumMg;
  final double? saturatedFattyAcidsMg;
  final double? monounsaturatedFattyAcidsMg;
  final double? polyunsaturatedFattyAcidsMg;
  final double? freeSugarG;
  final double? starchG;
  final double? vitaminKUg;
  final double? breakfastProbability;
  final double? lunchProbability;
  final double? dinnerProbability;
  final int combinedMeal;
  final double? price;

  Meal({
    required this.id,
    required this.mainMeal,
    required this.sideMeal,
    required this.completeMeal,
    required this.ingredients,
    required this.quantities,
    required this.mealIngredientIds,
    required this.energyKcal,
    required this.proteinG,
    required this.totalFatG,
    required this.carbohydratesG,
    required this.totalDietaryFibreG,
    required this.vitaminAUg,
    required this.vitaminDUg,
    required this.vitaminEUg,
    required this.calciumMg,
    required this.phosphorusMg,
    required this.magnesiumMg,
    required this.sodiumMg,
    required this.potassiumMg,
    required this.saturatedFattyAcidsMg,
    required this.monounsaturatedFattyAcidsMg,
    required this.polyunsaturatedFattyAcidsMg,
    required this.freeSugarG,
    required this.starchG,
    required this.vitaminKUg,
    required this.breakfastProbability,
    required this.lunchProbability,
    required this.dinnerProbability,
    required this.combinedMeal,
    required this.price,
  });

  factory Meal.fromJson(Map<String?, dynamic> json) {
    return Meal(
      id: json['_id'],
      mainMeal: json['Main Meal'],
      sideMeal: json['Side Meal'],
      completeMeal: json['Complete Meal'],
      ingredients: json['Ingredients'],
      quantities: json['Quantities'],
      mealIngredientIds: json['Meal_Ingredient_Ids'],
      energyKcal: json['Energy(Kcal)'],
      proteinG: json['Protein(g)'],
      totalFatG: json['Total fat(g)'],
      carbohydratesG: json['Carbohydrates(g)'],
      totalDietaryFibreG: json['Total Dietary Fibre(g)'],
      vitaminAUg: json['Vitamin A(µg)'],
      vitaminDUg: json['Vitamin D(µg)'],
      vitaminEUg: json['Vitamin E(mg)'],
      calciumMg: json['Calcium(mg)'],
      phosphorusMg: json['Phosphorus(mg)'],
      magnesiumMg: json['Magnesium(mg)'],
      sodiumMg: json['Sodium(mg)'],
      potassiumMg: json['Potassium(mg)'],
      saturatedFattyAcidsMg: json['Saturated Fatty Acids(mg)'],
      monounsaturatedFattyAcidsMg: json['Monounsaturated Fatty Acids(mg)'],
      polyunsaturatedFattyAcidsMg: json['Polyunsaturated Fatty Acids(mg)'],
      freeSugarG: json['Free sugar(g)'],
      starchG: json['Starch(g)'],
      vitaminKUg: json['Vitamin K(µg)'],
      breakfastProbability: json['Breakfast_Probability'],
      lunchProbability: json['Lunch_Probability'],
      dinnerProbability: json['Dinner_Probability'],
      combinedMeal: json['Combined_Meal'],
      price: json['Price'],
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      '_id': id,
      'Main Meal': mainMeal,
      'Side Meal': sideMeal,
      'Complete Meal': completeMeal,
      'Ingredients': ingredients,
      'Quantities': quantities,
      'Meal_Ingredient_Ids': mealIngredientIds,
      'Energy(Kcal)': energyKcal,
      'Protein(g)': proteinG,
      'Total fat(g)': totalFatG,
      'Carbohydrates(g)': carbohydratesG,
      'Total Dietary Fibre(g)': totalDietaryFibreG,
      'Vitamin A(µg)': vitaminAUg,
      'Vitamin D(µg)': vitaminDUg,
      'Vitamin E(mg)': vitaminEUg,
      'Calcium(mg)': calciumMg,
      'Phosphorus(mg)': phosphorusMg,
      'Magnesium(mg)': magnesiumMg,
      'Sodium(mg)': sodiumMg,
      'Potassium(mg)': potassiumMg,
      'Saturated Fatty Acids(mg)': saturatedFattyAcidsMg,
      'Monounsaturated Fatty Acids(mg)': monounsaturatedFattyAcidsMg,
      'Polyunsaturated Fatty Acids(mg)': polyunsaturatedFattyAcidsMg,
      'Free sugar(g)': freeSugarG,
      'Starch(g)': starchG,
      'Vitamin K(µg)': vitaminKUg,
      'Breakfast_Probability': breakfastProbability,
      'Lunch_Probability': lunchProbability,
      'Dinner_Probability': dinnerProbability,
      'Combined_Meal': combinedMeal,
      'Price': price,
    };
  }
}
