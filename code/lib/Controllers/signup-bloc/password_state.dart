// password_state.dart
class PasswordState {
  final String password;
  final String confirmPassword;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isValid;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  PasswordState({
    this.password = '',
    this.confirmPassword = '',
    this.passwordError,
    this.confirmPasswordError,
    this.isValid = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  PasswordState copyWith({
    String? password,
    String? confirmPassword,
    String? passwordError,
    String? confirmPasswordError,
    bool? isValid,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return PasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}