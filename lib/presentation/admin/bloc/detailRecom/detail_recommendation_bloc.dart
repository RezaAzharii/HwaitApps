import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/data/model/response/recommendation_response_model.dart';
import 'package:hwait_apps/data/repository/recommendation_repository.dart';

part 'detail_recommendation_event.dart';
part 'detail_recommendation_state.dart';

class DetailRecommendationBloc
    extends Bloc<DetailRecommendationEvent, DetailRecommendationState> {
  final RecommendationRepository repository;

  DetailRecommendationBloc(this.repository)
    : super(DetailRecommendationInitial()) {
    on<GetDetailRecommendation>((event, emit) async {
      emit(DetailRecommendationLoading());
      final result = await repository.getRecommendation(event.id);
      result.fold(
        (err) => emit(DetailRecommendationError(err)),
        (data) => emit(DetailRecommendationLoaded(data)),
      );
    });
  }
}
