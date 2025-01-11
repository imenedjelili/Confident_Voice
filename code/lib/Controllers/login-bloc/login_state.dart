// login_state.dart
class LoginState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isLoading;
  final bool isValid;
  final String? errorMessage;
  final bool isSuccess;

  LoginState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isLoading = false,
    this.isValid = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isLoading,
    bool? isValid,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}