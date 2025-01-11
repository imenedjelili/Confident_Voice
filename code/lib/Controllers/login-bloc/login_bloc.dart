// login_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confident_voice/data/repo/dummy_authentication.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DummyAuthentication _authentication;

  LoginBloc()
      : _authentication = DummyAuthentication(),
        super(LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = event.email;
    String? error;
    if (email.isEmpty) {
      error = 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      error = 'Enter a valid email';
    }

    emit(state.copyWith(
      email: email,
      emailError: error,
      isValid: _isFormValid(email, state.password),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    String? error;
    if (password.isEmpty) {
      error = 'Please enter your password';
    }

    emit(state.copyWith(
      password: password,
      passwordError: error,
      isValid: _isFormValid(state.email, password),
    ));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(isLoading: true));

    try {
      final isLoginSuccessful = await _authentication.doLogin(
        state.email,
        state.password,
      );

      if (isLoginSuccessful) {
        emit(state.copyWith(
          isSuccess: true,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Incorrect username or password',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'An error occurred during login',
      ));
    }
  }

  bool _isFormValid(String email, String password) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }
}
