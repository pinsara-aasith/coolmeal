import 'package:bloc/bloc.dart';
import 'package:coolmeal/models/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PopularMealBloc extends Bloc<PopularMealEvent, PopularMealState> {
  final FirebaseFirestore firestore;

  PopularMealBloc({required this.firestore}) : super(PopularMealInitial()) {
    on<FetchPopularMeals>(_onFetchPopularMeals);
  }

  Future<void> _onFetchPopularMeals(
      FetchPopularMeals event, Emitter<PopularMealState> emit) async {
    emit(PopularMealLoading());
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('meals')
          .orderBy('generatedTimes', descending: true)
          .limit(20)
          .get();

      List<Meal> meals = querySnapshot.docs
          .map((doc) =>
              Meal.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();

      emit(PopularMealLoaded(meals));
    } catch (e) {
      emit(PopularMealError("Failed to fetch meals ${e.toString()}"));
    }
  }
}

abstract class PopularMealState extends Equatable {
  const PopularMealState();

  @override
  List<Object?> get props => [];
}

class PopularMealInitial extends PopularMealState {}

class PopularMealLoading extends PopularMealState {}

class PopularMealLoaded extends PopularMealState {
  final List<Meal> meals;

  const PopularMealLoaded(this.meals);

  @override
  List<Object?> get props => [meals];
}

class PopularMealError extends PopularMealState {
  final String message;

  const PopularMealError(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class PopularMealEvent extends Equatable {
  const PopularMealEvent();
}

class FetchPopularMeals extends PopularMealEvent {
  @override
  List<Object> get props => [];
}
