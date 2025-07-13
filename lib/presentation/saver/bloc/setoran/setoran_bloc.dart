import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/data/model/request/saver/request_setoran_model.dart';
import 'package:hwait_apps/data/repository/setoran_repository.dart';

part 'setoran_event.dart';
part 'setoran_state.dart';

class SetoranBloc extends Bloc<SetoranEvent, SetoranState> {
  final SetoranRepository repository;

  SetoranBloc(this.repository) : super(SetoranInitial()) {
    on<SubmitSetoran>((event, emit) async {
      emit(SetoranLoading());
      final result = await repository.submitSetoran(event.request);
      result.fold(
        (failure) => emit(SetoranFailure(message: failure)),
        (data) => emit(SetoranSuccess(message: 'Setoran berhasil')),
      );
    });
  }
}
