import 'package:bloc/bloc.dart';
import 'package:hwait_apps/data/model/response/recommendation_response_model.dart';
import 'package:hwait_apps/data/repository/recommendation_repository.dart';

part 'admin_screen_event.dart';
part 'admin_screen_state.dart';

class AdminScreenBloc extends Bloc<AdminScreenEvent, AdminScreenState> {
  final RecommendationRepository recommendationRepository;

  AdminScreenBloc(this.recommendationRepository) : super(AdminScreenInitial()) {
    on<LoadAdminScreen>(_getAllRecommendation);
    on<DeleteRecommendation>(_deleteRecommendation);
  }

  Future<void> _getAllRecommendation(
    AdminScreenEvent event,
    Emitter<AdminScreenState> emit,
  ) async {
    emit(GetAllRecommendationLoading());
    final result = await recommendationRepository.getAllRecommendation();
    result.fold(
      (error) => emit(GetAllRecommendationError(message: error)),
      (recommendation) =>
          emit(GetAllRecommendationLoaded(allRecommendation: recommendation)),
    );
  }

  Future<void> _deleteRecommendation(
    AdminScreenEvent event,
    Emitter<AdminScreenState> emit,
  ) async {
    if (event is DeleteRecommendation) {
      emit(DeleteRecommendationLoading());

      final result = await recommendationRepository.deleteRecommendation(
        event.id,
      );

      result.fold(
        (error) => emit(DeleteRecommendationError(error)),
        (_) => emit(DeleteRecommendationSuccess('Berhasil menghapus')),
      );
    }
  }
}
