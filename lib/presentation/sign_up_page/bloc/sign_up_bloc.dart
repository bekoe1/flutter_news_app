import 'dart:async';
import 'dart:developer';

import 'package:NewsApp/domain/repositories/auth/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepo authRepo;

  SignUpBloc(this.authRepo) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {
      on<AttemptToSignUpEvent>(_onSignUpPressed);
    });
  }

  Future<void> _onSignUpPressed(
      AttemptToSignUpEvent event, Emitter<SignUpState> emit) async {
    try {
      final response = await authRepo.createUserWithEmailAndPass(
          email: event.email, pass: event.password, name: event.username);
      emit(SignUpSuccessfulState());
    } on FirebaseAuthException catch (e) {
      log(e.message!);
    }
  }
}
