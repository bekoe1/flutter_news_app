part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AttemptToSignUpEvent extends AuthEvent {
  final String password;
  final String email;
  final String username;

  AttemptToSignUpEvent({
    required this.password,
    required this.email,
    required this.username,
  });
}

class AttemptToLogInEvent extends AuthEvent {
  final String email;
  final String password;

  AttemptToLogInEvent({required this.email, required this.password});
}

class AttemptToSignUpWithGoogleEvent extends AuthEvent {}
