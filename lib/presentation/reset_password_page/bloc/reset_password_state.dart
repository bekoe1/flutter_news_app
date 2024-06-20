part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class VerifyingEmailSuccessState extends ResetPasswordState {
  final String email;

  VerifyingEmailSuccessState({required this.email});
}

class VerifyingEmailErrorState extends ResetPasswordState {
  final String error;

  VerifyingEmailErrorState({required this.error});
}
