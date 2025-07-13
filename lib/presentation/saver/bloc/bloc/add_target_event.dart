part of 'add_target_bloc.dart';


sealed class AddTargetEvent {}

class SubmitAddTarget extends AddTargetEvent {
  final TargetRequestModel data;

  SubmitAddTarget(this.data);
}