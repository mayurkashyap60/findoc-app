import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email,
        isEmailValid: _validateEmail(event.email),
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        isPasswordValid: _validatePassword(event.password),
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(const Duration(seconds: 1));

      // :white_check_mark: DEMO CREDENTIALS
      const demoEmail = 'test@demo.com';
      const demoPassword = 'Demo@123';

      final isEmailValid = _validateEmail(state.email);
      final isPasswordValid = _validatePassword(state.password);
      final isCorrectCredentials =
          state.email == demoEmail && state.password == demoPassword;

      if (isEmailValid && isPasswordValid && isCorrectCredentials) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }

  bool _validateEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }

  bool _validatePassword(String password) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }
}