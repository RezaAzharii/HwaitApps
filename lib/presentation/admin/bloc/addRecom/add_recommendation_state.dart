part of 'add_recommendation_bloc.dart';

abstract class AddRecommendationState {}

class AddRecommendationInitial extends AddRecommendationState {}

class AddRecommendationLoading extends AddRecommendationState {}

class AddRecommendationSuccess extends AddRecommendationState {
  final String message;

  AddRecommendationSuccess(this.message);
}

class AddRecommendationError extends AddRecommendationState {
  final String message;

  AddRecommendationError(this.message);
}
