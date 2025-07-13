import 'package:bloc/bloc.dart';
import 'package:hwait_apps/data/model/request/saver/request_target_model.dart';
import 'package:hwait_apps/data/repository/target_repository.dart';

part 'add_target_event.dart';
part 'add_target_state.dart';

class AddTargetBloc extends Bloc<AddTargetEvent, AddTargetState> {
  final TargetRepository repository;

  AddTargetBloc(this.repository) : super(AddTargetInitial()) {
    on<SubmitAddTarget>(_onSubmitTarget);
  }

  Future<void> _onSubmitTarget(
    SubmitAddTarget event,
    Emitter<AddTargetState> emit,
  ) async {
    emit(AddTargetLoading());

    final result = await repository.addTarget(event.data);

    result.fold(
      (failure) => emit(AddTargetError(failure)),
      (success) =>
          emit(AddTargetSuccess(success['message'] ?? 'Berhasil menambahkan')),
    );
  }
}
