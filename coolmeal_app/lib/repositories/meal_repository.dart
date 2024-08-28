import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/models/meal.dart';

class MealRepository {
  final FirebaseFirestore firestore;

  MealRepository({required this.firestore});

  Future<Meal> getMealById(String mealId) async {
    try {
      DocumentSnapshot doc = await firestore.collection('meals').doc(mealId).get();
      return Meal.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Error fetching meal: $e');
    }
  }
}
