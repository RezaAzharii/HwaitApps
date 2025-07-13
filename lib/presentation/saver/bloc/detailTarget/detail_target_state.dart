part of 'detail_target_bloc.dart';

abstract class DetailTargetState {}

class DetailTargetInitial extends DetailTargetState {}

class DetailTargetLoading extends DetailTargetState {}

class DetailTargetLoaded extends DetailTargetState {
  final TargetD target;
  final double totalSetoran;
  final double totalTarget;
  final double persentaseProgres;

  DetailTargetLoaded({
    required this.target,
    required this.totalSetoran,
    required this.totalTarget,
    required this.persentaseProgres,
  });
}

class DetailTargetError extends DetailTargetState {
  final String message;

  DetailTargetError(this.message);
}
