part of 'riwayat_tabungan_bloc.dart';

abstract class RiwayatTabunganState {}

class RiwayatTabunganInitial extends RiwayatTabunganState {}

class RiwayatTabunganLoading extends RiwayatTabunganState {}

class RiwayatTabunganLoaded extends RiwayatTabunganState {
  final List<RiwayatTabungan> riwayat;

  RiwayatTabunganLoaded(this.riwayat);
}

class RiwayatTabunganError extends RiwayatTabunganState {
  final String message;

  RiwayatTabunganError(this.message);
}
