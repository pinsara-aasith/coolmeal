class Meal {
  final String mainMeal;
  final String sideMeal;
  final String completeMeal;
  final String ingredients;
  final String quantities;
  final String mealIngredientIds;
  final double energyKcal;
  final double proteinG;
  final double totalFatG;
  final double carbohydratesG;
  final double totalDietaryFibreG;
  final double vitaminAUg;
  final double vitaminDUg;
  final double viatminKUg; // Note: This should probably be 'vitaminKug' 
  final double vitaminEMg;
  final double calciumMg;
  final double phosphorusMg;
  final double magnesiumMg;
  final double sodiumMg;
  final double potassiumMg;
  final double saturatedFattyAcidsMg;
  final double monounsaturatedFattyAcidsMg;
  final double polyunsaturatedFattyAcidsMg;
  final double freeSugarG;
  final double starchG;
  final String mealTime;
  final double generatedTimes;

  Meal({
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
    required this.viatminKUg,
    required this.vitaminEMg,
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
    required this.mealTime,
    required this.generatedTimes,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mainMeal: json['mainMeal'],
      sideMeal: json['sideMeal'],
      completeMeal: json['completeMeal'],
      ingredients: json['ingredients'],
      quantities: json['quantities'],
      mealIngredientIds: json['mealIngredientIds'],
      energyKcal: json['energyKcal'],
      proteinG: json['proteinG'],
      totalFatG: json['totalFatG'],
      carbohydratesG: json['carbohydratesG'],
      totalDietaryFibreG: json['totalDietaryFibreG'],
      vitaminAUg: json['vitaminAUg'],
      vitaminDUg: json['vitaminDUg'],
      viatminKUg: json['viatminKUg'], // Note: Check for the correct key name here
      vitaminEMg: json['vitaminEMg'],
      calciumMg: json['calciumMg'],
      phosphorusMg: json['phosphorusMg'],
      magnesiumMg: json['magnesiumMg'],
      sodiumMg: json['sodiumMg'],
      potassiumMg: json['potassiumMg'],
      saturatedFattyAcidsMg: json['saturatedFattyAcidsMg'],
      monounsaturatedFattyAcidsMg: json['monounsaturatedFattyAcidsMg'],
      polyunsaturatedFattyAcidsMg: json['polyunsaturatedFattyAcidsMg'],
      freeSugarG: json['freeSugarG'],
      starchG: json['starchG'],
      mealTime: json['mealTime'],
      generatedTimes: json['generatedTimes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mainMeal': mainMeal,
      'sideMeal': sideMeal,
      'completeMeal': completeMeal,
      'ingredients': ingredients,
      'quantities': quantities,
      'mealIngredientIds': mealIngredientIds,
      'energyKcal': energyKcal,
      'proteinG': proteinG,
      'totalFatG': totalFatG,
      'carbohydratesG': carbohydratesG,
      'totalDietaryFibreG': totalDietaryFibreG,
      'vitaminAUg': vitaminAUg,
      'vitaminDUg': vitaminDUg,
      'viatminKUg': viatminKUg, // Note: Ensure this matches the correct key
      'vitaminEMg': vitaminEMg,
      'calciumMg': calciumMg,
      'phosphorusMg': phosphorusMg,
      'magnesiumMg': magnesiumMg,
      'sodiumMg': sodiumMg,
      'potassiumMg': potassiumMg,
      'saturatedFattyAcidsMg': saturatedFattyAcidsMg,
      'monounsaturatedFattyAcidsMg': monounsaturatedFattyAcidsMg,
      'polyunsaturatedFattyAcidsMg': polyunsaturatedFattyAcidsMg,
      'freeSugarG': freeSugarG,
      'starchG': starchG,
      'mealTime': mealTime,
      'generatedTimes': generatedTimes,
    };
  }
}
