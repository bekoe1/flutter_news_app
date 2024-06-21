part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class SendingEmailLinkSuccessState extends ResetPasswordState {
  final String email;

  SendingEmailLinkSuccessState({required this.email});
}

class SendingEmailLinkErrorState extends ResetPasswordState {
  final String error;

  SendingEmailLinkErrorState({required this.error});
}
