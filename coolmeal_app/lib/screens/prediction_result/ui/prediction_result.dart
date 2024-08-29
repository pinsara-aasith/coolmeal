
import 'package:flutter/material.dart';

class PredictionResult extends StatelessWidget {
  final Map<String, dynamic> prediction;

  const PredictionResult({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal plan for your next week'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: prediction['prediction'].length,
          itemBuilder: (context, index) {
            final meal = prediction['prediction'][index];
            return Card(
              child: ListTile(
                title: Text('Meal ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Breakfast: ${meal['Breakfast']}'),
                    Text('Lunch: ${meal['Lunch']}'),
                    Text('Dinner: ${meal['Dinner']}'),
                    Text(
                        'Combined Ingredients: ${meal['Combined Ingredients']}'),
                    Text('Total Energy (Kcal): ${meal['Total Energy (Kcal)']}'),
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
