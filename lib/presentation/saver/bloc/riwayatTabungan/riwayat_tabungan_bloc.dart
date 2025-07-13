import 'package:bloc/bloc.dart';
import 'package:hwait_apps/data/model/response/response_riwayat_tabungan_model.dart';
import 'package:hwait_apps/data/repository/target_repository.dart';

part 'riwayat_tabungan_event.dart';
part 'riwayat_tabungan_state.dart';

class RiwayatTabunganBloc
    extends Bloc<RiwayatTabunganEvent, RiwayatTabunganState> {
  final TargetRepository repository;

  RiwayatTabunganBloc(this.repository) : super(RiwayatTabunganInitial()) {
    on<FetchRiwayatTabungan>((event, emit) async {
      emit(RiwayatTabunganLoading());
      final result = await repository.getRiwayatTabungan();
      result.fold(
        (error) => emit(RiwayatTabunganError(error)),
        (model) => emit(RiwayatTabunganLoaded(model.data ?? [])),
      );
    });
  }
}

