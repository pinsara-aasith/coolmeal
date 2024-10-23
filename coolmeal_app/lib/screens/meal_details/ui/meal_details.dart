// meal_details_page.dart

import 'package:coolmeal/screens/meal_details/bloc/meal_details_bloc.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:coolmeal/theming/styles.dart';
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
          body: Container(
            decoration: BoxDecoration(gradient: welcomeGradient),
            child: BlocBuilder<MealDetailsBloc, MealDetailsState>(
              builder: (context, state) {
                if (state is MealDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealDetailsLoaded) {
                  final meal = state.meal;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        Text(
                          meal.completeMeal,
                          style: TextStyles.font13Grey400Weight,
                        ),
                        const SizedBox(height: 16),

                        _buildMealInfoCard(
                          icon: Icons.restaurant,
                          label: 'Main Meal',
                          value: meal.mainMeal,
                        ),
                        _buildMealInfoCard(
                          icon: Icons.emoji_food_beverage,
                          label: 'Side Meal',
                          value: meal.sideMeal,
                        ),
                        _buildMealInfoCard(
                          icon: Icons.access_time,
                          label: 'Meal Time',
                          value: meal.mealTime,
                        ),
                        const Divider(),

                        _buildMealInfoCard(
                          icon: Icons.local_dining,
                          label: 'Ingredients',
                          value: meal.ingredients,
                        ),
                        _buildMealInfoCard(
                          icon: Icons.scale,
                          label: 'Ingredient Quantities',
                          value: meal.quantities,
                        ),
                        const SizedBox(height: 16),

                        const Divider(),

                        const SizedBox(height: 16),
                        // Nutritional information section
                        Text(
                          'Nutritional Breakdown',
                          style: TextStyles.font17Grey600Weight,
                        ),
                        const SizedBox(height: 8),
                        _buildNutrientProgress(
                            'Energy', meal.energyKcal, 2000, 'kcal'),
                        _buildNutrientProgress(
                            'Protein', meal.proteinG, 50, 'g'),
                        _buildNutrientProgress(
                            'Total Fat', meal.totalFatG, 70, 'g'),
                        _buildNutrientProgress(
                            'Carbohydrates', meal.carbohydratesG, 300, 'g'),
                        _buildNutrientProgress(
                            'Dietary Fibre', meal.totalDietaryFibreG, 30, 'g'),
                        _buildNutrientProgress(
                            'Vitamin A', meal.vitaminAUg, 20000, 'µg'),
                        _buildNutrientProgress(
                            'Vitamin D', meal.vitaminDUg, 10000, 'µg'),
                        _buildNutrientProgress(
                            'Vitamin K', meal.vitaminKUg, 20000, 'µg'),
                        _buildNutrientProgress(
                            'Vitamin E', meal.vitaminEMg, 15, 'mg'),
                        _buildNutrientProgress(
                            'Calcium', meal.calciumMg, 1000, 'mg'),
                        _buildNutrientProgress(
                            'Phosphorus', meal.phosphorusMg, 700, 'mg'),
                        _buildNutrientProgress(
                            'Magnesium', meal.magnesiumMg, 400, 'mg'),
                        _buildNutrientProgress(
                            'Sodium', meal.sodiumMg, 2300, 'mg'),
                        _buildNutrientProgress(
                            'Potassium', meal.potassiumMg, 4700, 'mg'),
                        _buildNutrientProgress('Saturated Fatty Acids',
                            meal.saturatedFattyAcidsMg, 20000, 'mg'),
                        _buildNutrientProgress('Monounsaturated Fatty Acids',
                            meal.monounsaturatedFattyAcidsMg, 20000, 'mg'),
                        _buildNutrientProgress('Polyunsaturated Fatty Acids',
                            meal.polyunsaturatedFattyAcidsMg, 20000, 'mg'),
                        _buildNutrientProgress(
                            'Free Sugar', meal.freeSugarG, 50, 'g'),
                        _buildNutrientProgress(
                            'Starch', meal.starchG, 300, 'g'),
                      ],
                    ),
                  );
                } else if (state is MealDetailsError) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return Container();
              },
            ),
          )),
    );
  }

  // Helper method to build meal info cards
  Widget _buildMealInfoCard(
      {required IconData icon, required String label, required String value}) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 30),
        title: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }

  // Helper method to build progress bars for nutritional values
  Widget _buildNutrientProgress(
      String label, double value, double dailyValue, String unit) {
    double progress = value / dailyValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: '$label: ',
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: '${value.toStringAsFixed(2)} $unit',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress > 1.0 ? 1.0 : progress,
          backgroundColor: Colors.grey[300],
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
