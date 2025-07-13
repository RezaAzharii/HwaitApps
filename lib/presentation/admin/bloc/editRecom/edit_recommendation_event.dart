part of 'edit_recommendation_bloc.dart';

sealed class EditRecommendationEvent {}

class GetRecommendationToEdit extends EditRecommendationEvent {
  final int id;
  GetRecommendationToEdit(this.id);
}

class UpdateRecommendation extends EditRecommendationEvent {
  final int id;
  final Map<String, dynamic> updatedData;

  UpdateRecommendation({
    required this.id,
    required this.updatedData,
  });
}
