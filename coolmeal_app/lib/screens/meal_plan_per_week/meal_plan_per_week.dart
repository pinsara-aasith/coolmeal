import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/models/meal_plan_collection.dart';
import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

const WeekDays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

class MealPlanPerWeekPage extends StatefulWidget {
  final MealPlanCollection mealPlanCollection;

  const MealPlanPerWeekPage({super.key, required this.mealPlanCollection});

  @override
  State<MealPlanPerWeekPage> createState() => _MealPlanPerWeekPageState();
}

class _MealPlanPerWeekPageState extends State<MealPlanPerWeekPage> {
  bool isLoading = false;

  Future<void> saveMealPlanCollection(String name, String description) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Update the mealPlanCollection with the user-provided name and description
      final updatedMealPlanCollection = MealPlanCollection(
        name: name,
        description: description,
        generatedTime: DateTime.now().toString(),
        mealPlans: widget.mealPlanCollection.mealPlans,
      );

      await FirebaseFirestore.instance.collection('generated_meal_plans').add({
        ...updatedMealPlanCollection.toJson(),
        'email': FirebaseAuth.instance.currentUser?.email
      }); // Assuming you have a toJson method in MealPlanCollection

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Meal Plan saved successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save Meal Plan: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> promptForNameAndDescription() async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    nameController.text = "New Meal Plan";

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save your meal plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Image(
                image: AssetImage('assets/images/familyeating.png'),
                width: 200,
                height: 200,
              ),
              Gap(20.h),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                final name = nameController.text;
                final description = descriptionController.text;

                if (name.isNotEmpty) {
                  Navigator.of(context).pop();
                  saveMealPlanCollection(name, description);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Please enter both name and description.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meal plan for the week'),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: welcomeGradient,
            ),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.mealPlanCollection.mealPlans.length,
                      itemBuilder: (context, index) {
                        final mealPlan =
                            widget.mealPlanCollection.mealPlans[index];

                        return Card(
                            elevation: 4,
                            shadowColor:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Stack(children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.mealPlan,
                                      arguments: [mealPlan.index]);
                                },
                                child: ListTile(
                                  title: Text(
                                    WeekDays[index % WeekDays.length],
                                    style: TextStyles.font18Blue700Weight,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Gap(10.h),
                                      Text(
                                        'Breakfast: ${mealPlan.breakfast}',
                                        style: TextStyles.font12Grey400Weight,
                                      ),
                                      const Divider(),
                                      Text(
                                        'Lunch: ${mealPlan.lunch}',
                                        style: TextStyles.font12Grey400Weight,
                                      ),
                                      const Divider(),
                                      Text(
                                        'Dinner: ${mealPlan.dinner}',
                                        style: TextStyles.font12Grey400Weight,
                                      ),
                                      const Divider(),
                                      Text(
                                        'Total Energy (Kcal): ${mealPlan.totalEnergy}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        'Price (Rs): ${mealPlan.price?.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 3,
                                  right: 3,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.mealPlan,
                                          arguments: [mealPlan.index]);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).primaryColor),
                                    child: const Text(
                                      'View Details',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ))
                            ]));
                      },
                    ),
                  ),
                  if (isLoading) const CircularProgressIndicator(),
                  Row(children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: isLoading ? null : promptForNameAndDescription,
                      child: const Text(
                        'Save Meal Plan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ))
                  ]),
                ]))));
  }
}
