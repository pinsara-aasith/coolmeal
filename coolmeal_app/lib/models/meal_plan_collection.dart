import 'package:coolmeal/models/meal_plan.dart';

class MealPlanCollection {
  final String name;
  final String description;
  final String generatedTime;
  
  final List<MealPlan> mealPlans;

  MealPlanCollection({
    required this.name,
    required this.description,
    required this.generatedTime,
    required this.mealPlans,
  });

  factory MealPlanCollection.fromJson(Map<String, dynamic> json) {
    var name = json['name'] ?? '';
    var description = json['name'] ?? '';
    var generatedTime = DateTime.now().toString();
    var mealPlansList = json['mealPlans'] as List;
    List<MealPlan> mealPlansObjects = mealPlansList.map((i) => MealPlan.fromJson(i)).toList();

    return MealPlanCollection(
      name: name,
      description:  description,
      generatedTime: generatedTime,
      mealPlans: mealPlansObjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'generatedTime': generatedTime,
      'mealPlans': mealPlans.map((meal) => meal.toJson()).toList(),
    };
  }
}
