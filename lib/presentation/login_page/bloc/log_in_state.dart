part of 'log_in_bloc.dart';

@immutable
abstract class LogInState {}

class LogInInitial extends LogInState {}

class LogInSuccessfulState extends LogInState {
  final UserModel user;

  LogInSuccessfulState({required this.user});
}

class LogInErrorState extends LogInState {
  final String error;

  LogInErrorState({required this.error});
}
