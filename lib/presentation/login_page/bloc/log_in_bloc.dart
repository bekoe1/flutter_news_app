import 'dart:async';
import 'dart:developer';

import 'package:NewsApp/domain/models/user_model.dart';
import 'package:NewsApp/domain/repositories/auth/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

@injectable
class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final AuthRepo authRepo;

  LogInBloc(this.authRepo) : super(LogInInitial()) {
    on<LogInEvent>((event, emit) async {
      if (event is AttemptToLogInEvent) {
        await _onLogInPressed(event, emit);
      }
    });
  }

  Future<void> _onLogInPressed(
      AttemptToLogInEvent event, Emitter<LogInState> emit) async {
    try {
      final user = await authRepo.logInWithEmailAndPass(
        email: event.email,
        pass: event.password,
      );
      emit(LogInSuccessfulState(user: user));
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      emit(LogInErrorState(error: e.message!));
    } catch (e) {
      emit(LogInErrorState(error: e.toString()));
      log(e.toString());
    }
  }
}
