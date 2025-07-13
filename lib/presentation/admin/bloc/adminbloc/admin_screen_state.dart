part of 'admin_screen_bloc.dart';

sealed class AdminScreenState {}

final class AdminScreenInitial extends AdminScreenState {}

final class GetAllRecommendationLoading extends AdminScreenState {}

final class GetAllRecommendationLoaded extends AdminScreenState {
  final RecommendationResponseModel allRecommendation;
  GetAllRecommendationLoaded({required this.allRecommendation});
}

final class GetAllRecommendationError extends AdminScreenState {
  final String message;
  GetAllRecommendationError({required this.message});
}

class DeleteRecommendationLoading extends AdminScreenState {}

class DeleteRecommendationSuccess extends AdminScreenState {
  final String message;
  DeleteRecommendationSuccess(this.message);
}

class DeleteRecommendationError extends AdminScreenState {
  final String message;
  DeleteRecommendationError(this.message);
}


