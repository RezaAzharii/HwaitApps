part of 'setoran_bloc.dart';

abstract class SetoranEvent {}

class SubmitSetoran extends SetoranEvent {
  final RequestSetoranModel request;

  SubmitSetoran(this.request);
}
