// meal_details_page.dart

import 'package:coolmeal/screens/meal_details/bloc/meal_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealDetailsPage extends StatelessWidget {
  final String mealId;

  const MealDetailsPage({Key? key, required this.mealId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealDetailsBloc(RepositoryProvider.of(context))
        ..add(FetchMealDetails(mealId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meal Details'),
        ),
        body: BlocBuilder<MealDetailsBloc, MealDetailsState>(
          builder: (context, state) {
            if (state is MealDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MealDetailsLoaded) {
              final meal = state.meal;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text('Main Meal: ${meal.mainMeal}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Side Meal: ${meal.sideMeal}', style: const TextStyle(fontSize: 18)),
                    Text('Complete Meal: ${meal.completeMeal}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    Text('Ingredients: ${meal.ingredients}', style: const TextStyle(fontSize: 16)),
                    Text('Quantities: ${meal.quantities}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    const Text('Nutritional Information:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildNutrientProgress('Energy', meal.energyKcal, 2000, 'kcal'),
                    _buildNutrientProgress('Protein', meal.proteinG, 50, 'g'),
                    _buildNutrientProgress('Total Fat', meal.totalFatG, 70, 'g'),
                    _buildNutrientProgress('Carbohydrates', meal.carbohydratesG, 300, 'g'),
                    _buildNutrientProgress('Dietary Fibre', meal.totalDietaryFibreG, 30, 'g'),
                    _buildNutrientProgress('Vitamin A', meal.vitaminAUg, 900, 'µg'),
                    _buildNutrientProgress('Vitamin D', meal.vitaminDUg, 20, 'µg'),
                    _buildNutrientProgress('Vitamin K', meal.viatminKUg, 120, 'µg'),
                    _buildNutrientProgress('Vitamin E', meal.vitaminEMg, 15, 'mg'),
                    _buildNutrientProgress('Calcium', meal.calciumMg, 1000, 'mg'),
                    _buildNutrientProgress('Phosphorus', meal.phosphorusMg, 700, 'mg'),
                    _buildNutrientProgress('Magnesium', meal.magnesiumMg, 400, 'mg'),
                    _buildNutrientProgress('Sodium', meal.sodiumMg, 2300, 'mg'),
                    _buildNutrientProgress('Potassium', meal.potassiumMg, 4700, 'mg'),
                    _buildNutrientProgress('Saturated Fatty Acids', meal.saturatedFattyAcidsMg, 20000, 'mg'),
                    _buildNutrientProgress('Monounsaturated Fatty Acids', meal.monounsaturatedFattyAcidsMg, 20000, 'mg'),
                    _buildNutrientProgress('Polyunsaturated Fatty Acids', meal.polyunsaturatedFattyAcidsMg, 20000, 'mg'),
                    _buildNutrientProgress('Free Sugar', meal.freeSugarG, 50, 'g'),
                    _buildNutrientProgress('Starch', meal.starchG, 300, 'g'),
                    const SizedBox(height: 16),
                    Text('Meal Time: ${meal.mealTime}', style: const TextStyle(fontSize: 16)),
                    Text('Generated Times: ${meal.generatedTimes}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              );
            } else if (state is MealDetailsError) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  // Helper method to build progress bars for nutritional values
  Widget _buildNutrientProgress(String label, double value, double dailyValue, String unit) {
    double progress = value / dailyValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text('$label: ${value.toStringAsFixed(2)} $unit'),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress > 1.0 ? 1.0 : progress,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
        ),
      ],
    );
  }
}
