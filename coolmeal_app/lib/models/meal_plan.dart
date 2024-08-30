class MealPlan {
  final String breakfast;
  final String lunch;
  final String dinner;
  final String combinedIngredients;
  final double totalEnergy;
  final double totalProtein;
  final double totalFat;
  final double totalCarbohydrates;
  final double totalMagnesium;
  final double totalSodium;
  final double totalPotassium;
  final double totalSaturatedFattyAcids;
  final double totalMonounsaturatedFattyAcids;
  final double totalPolyunsaturatedFattyAcids;
  final double totalFreeSugar;
  final double totalStarch;

  MealPlan({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.combinedIngredients,
    required this.totalEnergy,
    required this.totalProtein,
    required this.totalFat,
    required this.totalCarbohydrates,
    required this.totalMagnesium,
    required this.totalSodium,
    required this.totalPotassium,
    required this.totalSaturatedFattyAcids,
    required this.totalMonounsaturatedFattyAcids,
    required this.totalPolyunsaturatedFattyAcids,
    required this.totalFreeSugar,
    required this.totalStarch,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      breakfast: json['Breakfast'],
      lunch: json['Lunch'],
      dinner: json['Dinner'],
      combinedIngredients: json['Combined Ingredients'],
      totalEnergy: json['Total Energy (Kcal)'],
      totalProtein: json['Total Protein (g)'],
      totalFat: json['Total Fat (g)'],
      totalCarbohydrates: json['Total Carbohydrates (g)'],
      totalMagnesium: json['Total Magnesium (mg)'],
      totalSodium: json['Total Sodium (mg)'],
      totalPotassium: json['Total Potassium (mg)'],
      totalSaturatedFattyAcids: json['Total Saturated Fatty Acids (mg)'],
      totalMonounsaturatedFattyAcids: json['Total Monounsaturated Fatty Acids (mg)'],
      totalPolyunsaturatedFattyAcids: json['Total Polyunsaturated Fatty Acids (mg)'],
      totalFreeSugar: json['Total Free Sugar (g)'],
      totalStarch: json['Total Starch (g)'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Breakfast': breakfast,
      'Lunch': lunch,
      'Dinner': dinner,
      'Combined Ingredients': combinedIngredients,
      'Total Energy (Kcal)': totalEnergy,
      'Total Protein (g)': totalProtein,
      'Total Fat (g)': totalFat,
      'Total Carbohydrates (g)': totalCarbohydrates,
      'Total Magnesium (mg)': totalMagnesium,
      'Total Sodium (mg)': totalSodium,
      'Total Potassium (mg)': totalPotassium,
      'Total Saturated Fatty Acids (mg)': totalSaturatedFattyAcids,
      'Total Monounsaturated Fatty Acids (mg)': totalMonounsaturatedFattyAcids,
      'Total Polyunsaturated Fatty Acids (mg)': totalPolyunsaturatedFattyAcids,
      'Total Free Sugar (g)': totalFreeSugar,
      'Total Starch (g)': totalStarch,
    };
  }
}
