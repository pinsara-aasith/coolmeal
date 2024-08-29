
import 'package:coolmeal/models/meal_plan_collection.dart';
import 'package:flutter/material.dart';

const WeekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

class MealPlanPerDayPage extends StatelessWidget {
  final MealPlanCollection mealPlanCollection;

  const MealPlanPerDayPage({super.key, required this.mealPlanCollection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal plan for the week'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mealPlanCollection.mealPlans.length,
          itemBuilder: (context, index) {
            final meal = mealPlanCollection.mealPlans[index];
            return InkWell(child:Card(
              child: ListTile(
                title: Text(WeekDays[index % WeekDays.length]),
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
            ));
          },
        ),
      ),
    );
  }
}
