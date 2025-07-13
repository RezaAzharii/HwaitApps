part of 'detail_recommendation_bloc.dart';

abstract class DetailRecommendationState {}

class DetailRecommendationInitial extends DetailRecommendationState {}

class DetailRecommendationLoading extends DetailRecommendationState {}

class DetailRecommendationLoaded extends DetailRecommendationState {
  final Recom detail;
  DetailRecommendationLoaded(this.detail);
}

class DetailRecommendationError extends DetailRecommendationState {
  final String message;
  DetailRecommendationError(this.message);
}