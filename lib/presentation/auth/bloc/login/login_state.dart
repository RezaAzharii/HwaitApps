part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSucces extends LoginState {
  final AuthResponseModel responseModel;

  LoginSucces({required this.responseModel});
}

final class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}