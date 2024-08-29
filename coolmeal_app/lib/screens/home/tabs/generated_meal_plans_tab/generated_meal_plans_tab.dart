import 'package:coolmeal/screens/complete_profile/ui/widgets/page_header.dart';
import 'package:coolmeal/screens/home/tabs/generated_meal_plans_tab/bloc/generated_meal_plans_bloc.dart';
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
      child: BlocBuilder<MealPlanBloc, MealPlanState>(
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all( 28),
              child: Column(
                children: [
                  const CategoryTitle(
                      title: "Meal plans you've generated",
                      subtitle: "Your Meal Plans",
                      assetImagePath:
                          "assets/images/tell_me_more_about_you_2.png"),
                  if (state is MealPlanInitial)
                    const Center(child: Text('Please wait...')),
                  if (state is MealPlanLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is MealPlanLoaded)
                    state.mealPlans.isEmpty
                        ? const Center(child: Text('You haven\'t generated any meals earlier.'))
                        : Expanded(
                            child: ListView.builder(
                            itemCount: state.mealPlans.length,
                            itemBuilder: (context, index) {
                              final mealPlan = state.mealPlans[index];
                              return Card(
                                margin: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(mealPlan['title']),
                                  subtitle: Text(mealPlan['description']),
                                  trailing: Text(mealPlan['date']),
                                  onTap: () {
                                    // Navigate to meal plan details
                                  },
                                ),
                              );
                            },
                          )),
                  if (state is MealPlanError)
                    Center(child: Text(state.message)),
                ],
              ));
        },
      ),
    );
  }
}
