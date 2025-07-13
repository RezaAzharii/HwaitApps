part of 'detail_target_bloc.dart';

abstract class DetailTargetEvent {}

class FetchDetailTarget extends DetailTargetEvent {
  final int id;

  FetchDetailTarget(this.id);
}

class DeleteTarget extends DetailTargetEvent {
  final int id;

  DeleteTarget(this.id);
}