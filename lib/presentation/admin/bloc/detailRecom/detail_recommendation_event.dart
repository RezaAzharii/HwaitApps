part of 'detail_recommendation_bloc.dart';

abstract class DetailRecommendationEvent {}

class GetDetailRecommendation extends DetailRecommendationEvent {
  final int id;
  GetDetailRecommendation(this.id);
}