import 'package:bloc/bloc.dart';
import 'package:coolmeal/models/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/models/meal_plan_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeneratedMealBloc extends Bloc<GeneratedMealEvent, GeneratedMealState> {
  final FirebaseFirestore firestore;

  GeneratedMealBloc({required this.firestore}) : super(GeneratedMealInitial()) {
    on<FetchGeneratedMeals>(_onFetchGeneratedMeals);
  }

  Future<void> _onFetchGeneratedMeals(
      FetchGeneratedMeals event, Emitter<GeneratedMealState> emit) async {
    emit(GeneratedMealLoading());
    try {
      var querySnapshot = await firestore
          .collection('generated_meal_plans')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .get();

      List<MealPlanCollection> meals = querySnapshot.docs
          .map((doc) => MealPlanCollection.fromJson(doc.data()))
          .toList();

      emit(GeneratedMealLoaded(meals));
    } catch (e) {
      emit(GeneratedMealError("Failed to fetch meals ${e.toString()}"));
    }
  }
}

abstract class GeneratedMealState extends Equatable {
  const GeneratedMealState();

  @override
  List<Object?> get props => [];
}

class GeneratedMealInitial extends GeneratedMealState {}

class GeneratedMealLoading extends GeneratedMealState {}

class GeneratedMealLoaded extends GeneratedMealState {
  final List<MealPlanCollection> generatedMealPlans;

  const GeneratedMealLoaded(this.generatedMealPlans);

  @override
  List<Object?> get props => [generatedMealPlans];
}

class GeneratedMealError extends GeneratedMealState {
  final String message;

  const GeneratedMealError(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class GeneratedMealEvent extends Equatable {
  const GeneratedMealEvent();
}

class FetchGeneratedMeals extends GeneratedMealEvent {
  FetchGeneratedMeals();

  @override
  List<Object> get props => [];
}
