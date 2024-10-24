// meal_details_bloc.dart

import 'package:coolmeal/models/meal.dart';
import 'package:coolmeal/repositories/meal_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class MealDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMealDetails extends MealDetailsEvent {
  final String mealName;

  FetchMealDetails(this.mealName);

  @override
  List<Object?> get props => [mealName];
}

// States
abstract class MealDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsLoaded extends MealDetailsState {
  final Meal meal;

  MealDetailsLoaded(this.meal);

  @override
  List<Object?> get props => [meal];
}

class MealDetailsError extends MealDetailsState {
  final String error;

  MealDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}

// Bloc
class MealDetailsBloc extends Bloc<MealDetailsEvent, MealDetailsState> {
  final MealRepository mealRepository;

  MealDetailsBloc(this.mealRepository) : super(MealDetailsInitial()) {
    on<FetchMealDetails>(_onFetchMealDetails);
  }

  Future<void> _onFetchMealDetails(
      FetchMealDetails event, Emitter<MealDetailsState> emit) async {
    emit(MealDetailsLoading());
    try {
      final meal = await mealRepository.getMealByName(event.mealName);
      emit(MealDetailsLoaded(meal));
    } catch (e) {
      emit(MealDetailsError(e.toString()));
    }
  }
}
