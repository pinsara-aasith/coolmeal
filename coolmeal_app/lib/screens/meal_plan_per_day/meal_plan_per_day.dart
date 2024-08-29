
import 'package:coolmeal/models/meal_plan_collection.dart';
import 'package:flutter/material.dart';

class MealPlanPerDayPage extends StatelessWidget {
  final MealPlanCollection mealPlanCollection;

  const MealPlanPerDayPage({super.key, required this.mealPlanCollection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal plan for your next week'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mealPlanCollection.mealPlans.length,
          itemBuilder: (context, index) {
            final meal = mealPlanCollection.mealPlans[index];
            return Card(
              child: ListTile(
                title: Text('Meal ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Breakfast: ${meal.breakfast}'),
                    Text('Lunch: ${meal.lunch}'),
                    Text('Dinner: ${meal.dinner}'),
                    Text(
                        'Combined Ingredients: ${meal.combinedIngredients}'),
                    Text('Total Energy (Kcal): ${meal.totalEnergy}'),
                    // Add more nutritional details as needed
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
