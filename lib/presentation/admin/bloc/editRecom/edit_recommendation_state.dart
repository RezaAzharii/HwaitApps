part of 'edit_recommendation_bloc.dart';

sealed class EditRecommendationState {}

class EditRecommendationInitial extends EditRecommendationState {}

class GetRecommendationLoading extends EditRecommendationState {}

class GetRecommendationSuccess extends EditRecommendationState {
  final Recom data;
  GetRecommendationSuccess(this.data);
}

class GetRecommendationError extends EditRecommendationState {
  final String message;
  GetRecommendationError(this.message);
}

class UpdateRecommendationLoading extends EditRecommendationState {}

class UpdateRecommendationSuccess extends EditRecommendationState {
  final String message;
  UpdateRecommendationSuccess({required this.message});
}

class UpdateRecommendationError extends EditRecommendationState {
  final String message;
  UpdateRecommendationError({required this.message});
}
