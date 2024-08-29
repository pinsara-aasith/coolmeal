import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/models/meal.dart';
import 'package:coolmeal/models/meal_plan.dart';

class MealRepository {
  final FirebaseFirestore firestore;

  MealRepository({required this.firestore});

  Future<Meal> getMealById(String mealId) async {
    try {
      DocumentSnapshot doc =
          await firestore.collection('meals').doc(mealId).get();
      return Meal.fromJson(doc.id, doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error fetching meal: $e');
    }
  }

  Future<MealPlan?> getMealPlanByMealNames(
      String breakfast, String lunch, String dinner) async {
    try {
      QuerySnapshot query = await firestore
          .collection('meals')
          .where(breakfast, isEqualTo: breakfast)
          .where(breakfast, isEqualTo: breakfast)
          .where(breakfast, isEqualTo: breakfast)
          .get();

      if (query.docs.isNotEmpty) {
        return MealPlan.fromJson(
            query.docs.first.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception('Error fetching meal: $e');
    }
    return null;
  }
}
