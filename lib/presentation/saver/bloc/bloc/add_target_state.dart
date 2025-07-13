part of 'add_target_bloc.dart';

sealed class AddTargetState {}

final class AddTargetInitial extends AddTargetState {}

class AddTargetLoading extends AddTargetState {}

class AddTargetSuccess extends AddTargetState {
  final String message;

  AddTargetSuccess(this.message);
}

class AddTargetError extends AddTargetState{
  final String error;

  AddTargetError(this.error);
}