import 'dart:async';

import 'package:NewsApp/domain/repositories/auth/auth_repo.dart';
import 'package:bloc/bloc.dart';
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
    final response = await authRepo.isEmailInDb(event.email);
    if (response) {
      emit(
        VerifyingEmailSuccessState(email: event.email),
      );
    } else if (!response) {
      emit(
        VerifyingEmailErrorState(error: "Email not found"),
      );
    } else {
      emit(
        VerifyingEmailErrorState(error: "Error occupied"),
      );
    }
  }
}
