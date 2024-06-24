import 'dart:async';
import 'dart:developer';

import 'package:NewsApp/domain/models/user_model.dart';
import 'package:NewsApp/domain/repositories/auth/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<AttemptToSignUpEvent>(_onSignUpPressed);
    on<AttemptToSignUpWithGoogleEvent>(_onGoogleSignUpPressed);
    on<AttemptToLogInEvent>(_onLogInPressed);
  }

  Future<void> _onSignUpPressed(
      AttemptToSignUpEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await authRepo.createUserWithEmailAndPass(
          email: event.email, pass: event.password, name: event.username);
      //TODO cash data
      emit(SignUpSuccessfulState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.message!));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  Future<void> _onGoogleSignUpPressed(
      AttemptToSignUpWithGoogleEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await authRepo.logInWithGoogle();
      if (response != null) {
        emit(AuthSuccessfulState(user: response));
      } else {
        emit(
          AuthErrorState(error: "Error with google sign in"),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(error: e.message!));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  Future<void> _onLogInPressed(
      AttemptToLogInEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepo.logInWithEmailAndPass(
        email: event.email,
        pass: event.password,
      );
      emit(AuthSuccessfulState(user: user));
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      emit(AuthErrorState(error: e.message!));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
      log(e.toString());
    }
  }
}
