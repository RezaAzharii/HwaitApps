import 'package:bloc/bloc.dart';
import 'package:hwait_apps/data/model/response/recommendation_response_model.dart';
import 'package:hwait_apps/data/repository/recommendation_repository.dart';

part 'edit_recommendation_event.dart';
part 'edit_recommendation_state.dart';

class EditRecommendationBloc extends Bloc<EditRecommendationEvent, EditRecommendationState> {
  final RecommendationRepository recommendationRepository;

  EditRecommendationBloc(this.recommendationRepository) : super(EditRecommendationInitial()) {
    on<GetRecommendationToEdit>(_getRecommendationToEdit);
    on<UpdateRecommendation>(_updateRecommendation);
  }

  Future<void> _getRecommendationToEdit(
    GetRecommendationToEdit event,
    Emitter<EditRecommendationState> emit,
  ) async {
    emit(GetRecommendationLoading());

    final result = await recommendationRepository.getRecommendation(event.id);
    result.fold(
      (error) => emit(GetRecommendationError(error)),
      (data) => emit(GetRecommendationSuccess(data)),
    );
  }

  Future<void> _updateRecommendation(
    UpdateRecommendation event,
    Emitter<EditRecommendationState> emit,
  ) async {
    emit(UpdateRecommendationLoading());

    final result = await recommendationRepository.updateRecommendation(
      event.id,
      event.updatedData,
    );

    result.fold(
      (error) => emit(UpdateRecommendationError(message: error)),
      (_) => emit(UpdateRecommendationSuccess(message: 'Berhasil diperbarui')),
    );
  }
}
