part of 'log_in_bloc.dart';

@immutable
abstract class LogInEvent {}

class AttemptToLogInEvent extends LogInEvent {
  final String email;
  final String password;

  AttemptToLogInEvent({required this.email, required this.password});
}
