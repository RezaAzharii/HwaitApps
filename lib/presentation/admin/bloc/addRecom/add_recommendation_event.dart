part of 'add_recommendation_bloc.dart';

abstract class AddRecommendationEvent {}

class SubmitAddRecommendation extends AddRecommendationEvent {
  final RecommendationRequestModel data;

  SubmitAddRecommendation(this.data);
}
