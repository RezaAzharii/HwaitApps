import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/data/model/request/admin/recommendation_request_model.dart';
import 'package:hwait_apps/data/repository/recommendation_repository.dart';

part 'add_recommendation_event.dart';
part 'add_recommendation_state.dart';

class AddRecommendationBloc extends Bloc<AddRecommendationEvent, AddRecommendationState> {
  final RecommendationRepository repository;

  AddRecommendationBloc(this.repository) : super(AddRecommendationInitial()) {
    on<SubmitAddRecommendation>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitAddRecommendation event,
    Emitter<AddRecommendationState> emit,
  ) async {
    emit(AddRecommendationLoading());

    final result = await repository.addRecommendation(event.data);

    result.fold(
      (failure) => emit(AddRecommendationError(failure)),
      (success) => emit(AddRecommendationSuccess(success['message'] ?? 'Berhasil menambahkan')),
    );
  }
}
