part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignUpSuccessfulState extends AuthState {}

class AuthSuccessfulState extends AuthState {
  final UserModel user;

  AuthSuccessfulState({required this.user});
}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
}
