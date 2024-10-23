import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:coolmeal/main.dart';
import 'package:coolmeal/models/meal.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class PopularMealBloc extends Bloc<PopularMealEvent, PopularMealState> {

  PopularMealBloc()
      : super(PopularMealInitial()) {
    on<FetchPopularMeals>(_onFetchPopularMeals);
  }

  Future<void> _onFetchPopularMeals(
      FetchPopularMeals event, Emitter<PopularMealState> emit) async {
    emit(PopularMealLoading());
    // try {
      String url = '$ServerIP/meals/${event.mealTime?.toLowerCase() ?? 'breakfast'}/top50';
      // Adding filters if mealTime or searchQuery are provided
      Map<String, String> queryParams = {};
      if (event.mealTime != null) {
        queryParams['mealTime'] = event.mealTime!;
      }
      if (event.searchQuery != null) {
        queryParams['searchQuery'] = event.searchQuery!;
      }
      Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<Meal> meals = data["meals"].map<Meal>((md) => Meal.fromJson(md)).toList();
        emit(PopularMealLoaded(meals));
      } else {
        emit(PopularMealError("Failed to fetch meals: ${response.statusCode}"));
      }
    // } catch (e) {
    //   emit(PopularMealError("Failed to fetch meals: ${e.toString()}"));
    // }
  }
}

// Abstract PopularMealState class and its variants
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

// Abstract PopularMealEvent class and its variants
abstract class PopularMealEvent extends Equatable {
  const PopularMealEvent();
}

class FetchPopularMeals extends PopularMealEvent {
  final String? searchQuery;
  final String? mealTime;

  const FetchPopularMeals({this.searchQuery, this.mealTime});

  @override
  List<Object> get props => [];
}
