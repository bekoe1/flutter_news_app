part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class AttemptToSignUpEvent extends SignUpEvent {
  final String password;
  final String email;
  final String username;

  AttemptToSignUpEvent({
    required this.password,
    required this.email,
    required this.username,
  });
}
