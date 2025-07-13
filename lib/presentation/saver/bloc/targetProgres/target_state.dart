part of 'target_bloc.dart';

abstract class TargetState {}

class TargetInitial extends TargetState {}

class TargetLoading extends TargetState {}

class TargetLoaded extends TargetState {
  final List<Target> targets;

  TargetLoaded({required this.targets});
}

class TargetError extends TargetState {
  final String message;

  TargetError({required this.message});
}


