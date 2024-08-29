import 'package:coolmeal/models/meal_plan.dart';

class MealPlanCollection {
  final List<MealPlan> mealPlans;

  MealPlanCollection({
    required this.mealPlans,
  });

  factory MealPlanCollection.fromJson(Map<String, dynamic> json) {
    var mealPlansList = json['mealPlans'] as List;
    List<MealPlan> mealPlansObjects = mealPlansList.map((i) => MealPlan.fromJson(i)).toList();

    return MealPlanCollection(
      mealPlans: mealPlansObjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealPlans': mealPlans.map((meal) => meal.toJson()).toList(),
    };
  }
}
