import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  final FirebaseFirestore _firestore;

  MealPlanBloc(this._firestore) : super(MealPlanInitial()) {
    on<FetchMealPlans>(onFetchMeals);
  }

  void onFetchMeals(FetchMealPlans event, Emitter<MealPlanState> emit) async {
    emit(MealPlanLoading());
    try {
      // final snapshot = await _firestore
      //     .collection('mealPlans')
      //     .where('userId', isEqualTo: event.userId)
      //     .get();

      // final mealPlans = snapshot.docs.map((doc) => doc.data()).toList();
      emit(const MealPlanLoaded([]));
    } catch (e) {
      emit(const MealPlanError('Failed to load meal plans.'));
    }
  }
}

abstract class MealPlanState extends Equatable {
  const MealPlanState();

  @override
  List<Object> get props => [];
}

class MealPlanInitial extends MealPlanState {}

class MealPlanLoading extends MealPlanState {}

class MealPlanLoaded extends MealPlanState {
  final List<Map<String, dynamic>> mealPlans;
  const MealPlanLoaded(this.mealPlans);

  @override
  List<Object> get props => [mealPlans];
}

class MealPlanError extends MealPlanState {
  final String message;

  const MealPlanError(this.message);

  @override
  List<Object> get props => [message];
}

abstract class MealPlanEvent extends Equatable {
  const MealPlanEvent();

  @override
  List<Object> get props => [];
}

class FetchMealPlans extends MealPlanEvent {
  final String userId;

  const FetchMealPlans(this.userId);

  @override
  List<Object> get props => [userId];
}
