part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpSuccessfulState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState({required this.error});
}
