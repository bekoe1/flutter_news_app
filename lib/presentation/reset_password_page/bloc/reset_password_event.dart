part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent {}

class AttemptToVerifyEmailEvent extends ResetPasswordEvent {
  final String email;

  AttemptToVerifyEmailEvent({required this.email});
}
