// meal_details_page.dart

import 'package:coolmeal/models/meal.dart';
import 'package:coolmeal/repositories/meal_repository.dart';
import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/screens/meal_details/bloc/meal_details_bloc.dart';
import 'package:coolmeal/screens/meal_plan_per_day/ui/meal_plan_details_bloc.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealPlanDetailsPage extends StatelessWidget {
  final int index;

  const MealPlanDetailsPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MealPlanDetailsBloc(RepositoryProvider.of<MealRepository>(context))
            ..add(FetchMealPlanDetails(index)),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Meal Details'),
          ),
          body: Container(
            decoration: BoxDecoration(gradient: welcomeGradient),
            child: BlocBuilder<MealPlanDetailsBloc, MealPlanDetailsState>(
              builder: (context, state) {
                if (state is MealPlanDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MealPlanDetailsLoaded) {
                  final mealPlan = state.mealPlan;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        _buildMealInfoCard(
                          context,
                          icon: Icons.sunny,
                          label: 'Breakfast',
                          value: mealPlan.breakfast ?? '',
                        ),
                        _buildMealInfoCard(
                          context,
                          icon: Icons.restaurant,
                          label: 'Lunch',
                          value: mealPlan.lunch ?? '',
                        ),
                        _buildMealInfoCard(
                          context,
                          icon: Icons.sunny_snowing,
                          label: 'Dinner',
                          value: mealPlan.dinner ?? '',
                        ),
                        const Divider(),
                        Text(
                          'Rs. ${mealPlan.price?.toStringAsFixed(2)}',
                          style: TextStyles.font20DarkBlue700Weight,
                          textAlign: TextAlign.center,
                        ),
                        const Divider(),
                        const SizedBox(height: 16),
                        // Nutritional information section
                        Text(
                          'Nutritional Breakdown',
                          style: TextStyles.font17Grey600Weight,
                        ),
                        const SizedBox(height: 8),
                        _buildNutrientProgress(
                            'Energy', mealPlan.totalEnergy, 2000, 'kcal'),
                        _buildNutrientProgress(
                            'Protein', mealPlan.totalProtein, 50, 'g'),
                        _buildNutrientProgress(
                            'Total Fat', mealPlan.totalFat, 70, 'g'),
                        _buildNutrientProgress('Carbohydrates',
                            mealPlan.totalCarbohydrates, 300, 'g'),

                        _buildNutrientProgress(
                            'Magnesium', mealPlan.totalMagnesium, 400, 'mg'),
                        _buildNutrientProgress(
                            'Sodium', mealPlan.totalSodium, 2300, 'mg'),
                        _buildNutrientProgress(
                            'Potassium', mealPlan.totalPotassium, 4700, 'mg'),
                        _buildNutrientProgress('Saturated Fatty Acids',
                            mealPlan.totalSaturatedFattyAcids, 20000, 'mg'),
                        _buildNutrientProgress(
                            'Monounsaturated Fatty Acids',
                            mealPlan.totalMonounsaturatedFattyAcids,
                            20000,
                            'mg'),
                        _buildNutrientProgress(
                            'Polyunsaturated Fatty Acids',
                            mealPlan.totalPolyunsaturatedFattyAcids,
                            20000,
                            'mg'),
                        _buildNutrientProgress(
                            'Free Sugar', mealPlan.totalFreeSugar, 50, 'g'),
                        _buildNutrientProgress(
                            'Starch', mealPlan.totalStarch, 300, 'g'),
                      ],
                    ),
                  );
                } else if (state is MealDetailsError) {
                  return Center(
                      child:
                          Text('Error: ${(state as MealDetailsError).error}'));
                }
                return Container();
              },
            ),
          )),
    );
  }

  // Helper method to build meal info cards
  Widget _buildMealInfoCard(BuildContext context,
      {required IconData icon,
      required String label,
      required String value,
      }) {
    return Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.mealItem, arguments: [value]);
          },
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
        ));
  }

  // Helper method to build progress bars for nutritional values
  Widget _buildNutrientProgress(
      String label, double? value, double dailyValue, String unit) {
    double progress = (value ?? 0) / dailyValue;

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
                text: '${value?.toStringAsFixed(2)} $unit',
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
