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
              padding: const EdgeInsets.all( 28),
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
                        ? const Center(child: Text('You haven\'t generated any meal plans earlier.'))
                        : Expanded(
                            child: ListView.builder(
                            itemCount: state.generatedMealPlans.length,
                            itemBuilder: (context, index) {
                              final generatedMealPlan = state.generatedMealPlans[index];
                              return Card(
                                margin: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(generatedMealPlan.name),
                                  subtitle: Text(generatedMealPlan.description),
                                  // trailing: Text(generatedMealPlan.),
                                  onTap: () {
                                    // Navigate to meal plan details
                                  },
                                ),
                              );
                            },
                          )),
                  if (state is GeneratedMealError)
                    Center(child: Text(state.message)),
                ],
              ));
        },
      ),
    );
  }
}
