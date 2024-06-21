import 'dart:async';

import 'package:NewsApp/domain/repositories/auth/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

@injectable
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthRepo authRepo;

  ResetPasswordBloc(this.authRepo) : super(ResetPasswordInitial()) {
    on<AttemptToVerifyEmailEvent>(_onAttemptTOVerifyEmail);
  }

  Future<void> _onAttemptTOVerifyEmail(
      AttemptToVerifyEmailEvent event, Emitter<ResetPasswordState> emit) async {
    try {
      final response = await authRepo.sendPasswordResetLink(email: event.email);
      emit(
        SendingEmailLinkSuccessState(email: event.email),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        SendingEmailLinkErrorState(error: e.message!),
      );
    } catch (e) {
      emit(
        SendingEmailLinkErrorState(
          error: e.toString(),
        ),
      );
    }
  }
}
