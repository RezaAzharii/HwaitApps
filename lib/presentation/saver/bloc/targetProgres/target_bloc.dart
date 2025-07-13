import 'package:bloc/bloc.dart';
import 'package:hwait_apps/data/model/response/response_target_model.dart';
import 'package:hwait_apps/data/repository/target_repository.dart';

part 'target_event.dart';
part 'target_state.dart';

class TargetBloc extends Bloc<TargetEvent, TargetState> {
  final TargetRepository targetRepository;

  TargetBloc({required this.targetRepository}) : super(TargetInitial()) {
    on<FetchActiveTargets>((event, emit) async {
      emit(TargetLoading());
      try {
        final targets = await targetRepository.getActiveTargets();
        emit(TargetLoaded(targets: targets));
      } catch (e) {
        emit(TargetError(message: e.toString()));
      }
    });
  }
}
