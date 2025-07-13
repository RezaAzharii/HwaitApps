import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/data/model/response/response_detail_target_model.dart';
import 'package:hwait_apps/data/repository/target_repository.dart';

part 'detail_target_event.dart';
part 'detail_target_state.dart';

class DetailTargetBloc extends Bloc<DetailTargetEvent, DetailTargetState> {
  final TargetRepository repository;

  DetailTargetBloc(this.repository) : super(DetailTargetInitial()) {
    on<FetchDetailTarget>(_onLoadDetail);
    on<DeleteTarget>(_onDeleteTarget);
  }

  Future<void> _onLoadDetail(
    FetchDetailTarget event,
    Emitter<DetailTargetState> emit,
  ) async {
    emit(DetailTargetLoading());

    try {
      final response = await repository.getDetailTarget(event.id);
      final data = response.data;

      if (data?.target != null) {
        emit(
          DetailTargetLoaded(
            target: data!.target!,
            totalTarget: (data.totalTarget ?? 0).toDouble(),
            totalSetoran: (data.totalSetoran ?? 0).toDouble(),
            persentaseProgres:
                double.tryParse(data.persentaseProgres ?? '0') ?? 0.0,
          ),
        );
      } else {
        emit(DetailTargetError('Data tidak ditemukan'));
      }
    } catch (e) {
      emit(DetailTargetError('Terjadi kesalahan: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteTarget(
    DeleteTarget event,
    Emitter<DetailTargetState> emit,
  ) async {
    emit(DeleteTargetLoading());

    final result = await repository.deleteTarget(event.id);

    result.fold(
      (error) => emit(DeleteTargetError(error)),
      (_) => emit(DeleteTargetSuccess('Berhasil menghapus')),
    );
  }
}
