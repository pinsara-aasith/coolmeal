import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/screens/complete_profile/ui/widgets/page_header.dart';
import 'package:coolmeal/screens/home/tabs/generated_meal_plans_tab/generated_meal_plans_bloc.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneratedMealsComboTab extends StatefulWidget {
  const GeneratedMealsComboTab({Key? key}) : super(key: key);

  @override
  State<GeneratedMealsComboTab> createState() => _GeneratedMealsComboTabState();
}

class _GeneratedMealsComboTabState extends State<GeneratedMealsComboTab> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.gradient.withAlpha(100),
      ),
      child: BlocBuilder<GeneratedMealBloc, GeneratedMealState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const CategoryTitle(
                      title: "Meal plans you've saved",
                      subtitle: "Your Meal Plans",
                      assetImagePath:
                          "assets/images/tell_me_more_about_you_2.png"),
                  if (state is GeneratedMealInitial)
                    const Center(child: Text('Please wait...')),
                  if (state is GeneratedMealLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is GeneratedMealLoaded)
                    state.generatedMealPlans.isEmpty
                        ? const Center(
                            child: Text(
                                'You haven\'t generated any meal plans earlier.'))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: state.generatedMealPlans.length,
                              itemBuilder: (context, index) {
                                final generatedMealPlan =
                                    state.generatedMealPlans[index];
                                final totalCalories =
                                    generatedMealPlan.mealPlans.fold(0.0,
                                        (sum, m) => sum + (m.totalEnergy ?? 0));
                                final totalCost = generatedMealPlan.mealPlans
                                    .fold(0.0,
                                        (sum, m) => sum + (m.price ?? 0)); //
                                final avgCalories = totalCalories /
                                    generatedMealPlan.mealPlans.length;
                                final totalCostPerWeek =
                                    totalCost * 7; // Assume 7 days per week

                                return Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.all(12.0),
                                    child: InkWell(
                                      onTap: () {
                                                Navigator.pushNamed(context,
                                                    Routes.mealPlanPerWeek,
                                                    arguments: [
                                                      generatedMealPlan
                                                    ]);
                                              },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              title: Text(
                                                generatedMealPlan.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.teal[800],
                                                ),
                                              ),
                                              subtitle: Text(
                                                generatedMealPlan.description,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              trailing: Icon(Icons.fastfood,
                                                  color: Colors.teal[800]),
                                              
                                            ),
                                            const SizedBox(height: 8),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .local_fire_department,
                                                        color: Colors.red[400]),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'Avg Calories: ${avgCalories.toStringAsFixed(0)} kcal',
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.attach_money,
                                                        color:
                                                            Colors.green[400]),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'Total Cost (Week): \Rs.${totalCostPerWeek.toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Meals: ${generatedMealPlan.mealPlans.length}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                  if (state is GeneratedMealError)
                    Center(child: Text(state.message)),
                ],
              ));
        },
      ),
    );
  }
}
