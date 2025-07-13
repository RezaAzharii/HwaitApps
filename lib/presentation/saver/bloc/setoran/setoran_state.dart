part of 'setoran_bloc.dart';

abstract class SetoranState {}

class SetoranInitial extends SetoranState {}

class SetoranLoading extends SetoranState {}

class SetoranSuccess extends SetoranState {
  final String message;

  SetoranSuccess({required this.message});
}

class SetoranFailure extends SetoranState {
  final String message;

  SetoranFailure({required this.message});
}
