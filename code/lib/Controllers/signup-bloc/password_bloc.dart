// password_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confident_voice/data/repo/dummy_authentication.dart';
import 'password_event.dart';
import 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final String email;
  final DummyAuthentication _authentication;

  PasswordBloc({required this.email})
      : _authentication = DummyAuthentication(),
        super(PasswordState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SubmitForm>(_onSubmitForm);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<PasswordState> emit) {
    final newPassword = event.password;
    String? passwordError;
    String? confirmPasswordError;

    // Always show password requirements unless the password is empty
    if (newPassword.isNotEmpty) {
      passwordError = _getPasswordRequirements(newPassword);
      
      // Add a small delay before clearing requirements when all are met
      if (_meetsAllRequirements(newPassword)) {
        Future.delayed(const Duration(milliseconds: 500), () {
          emit(state.copyWith(
            passwordError: null,
            isValid: _isFormValid(newPassword, state.confirmPassword),
          ));
        });
      }
    }

    // Check password match only if confirm password is not empty
    if (state.confirmPassword.isNotEmpty) {
      if (newPassword == state.confirmPassword) {
        // Add delay before clearing match error
        Future.delayed(const Duration(milliseconds: 500), () {
          emit(state.copyWith(
            confirmPasswordError: null,
            isValid: _isFormValid(newPassword, state.confirmPassword),
          ));
        });
        confirmPasswordError = "✓ Passwords match";
      } else {
        confirmPasswordError = "Passwords do not match";
      }
    }

    emit(state.copyWith(
      password: newPassword,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      isValid: _isFormValid(newPassword, state.confirmPassword),
    ));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<PasswordState> emit) {
    final newConfirmPassword = event.confirmPassword;
    String? confirmPasswordError;

    // Only show match status if confirm password is not empty
    if (newConfirmPassword.isNotEmpty) {
      if (state.password == newConfirmPassword) {
        // Add delay before clearing match error
        Future.delayed(const Duration(milliseconds: 500), () {
          emit(state.copyWith(
            confirmPasswordError: null,
            isValid: _isFormValid(state.password, newConfirmPassword),
          ));
        });
        confirmPasswordError = "✓ Passwords match";
      } else {
        confirmPasswordError = "Passwords do not match";
      }
    }

    emit(state.copyWith(
      confirmPassword: newConfirmPassword,
      confirmPasswordError: confirmPasswordError,
      isValid: _isFormValid(state.password, newConfirmPassword),
    ));
  }

  Future<void> _onSubmitForm(
      SubmitForm event, Emitter<PasswordState> emit) async {
    if (!_isFormValid(state.password, state.confirmPassword)) return;

    emit(state.copyWith(isLoading: true));

    try {
      final isSignupSuccessful = await _authentication.doSignup(
        email,
        state.password,
        state.confirmPassword,
      );

      if (isSignupSuccessful) {
        emit(state.copyWith(isSuccess: true, isLoading: false));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: "Signup Failed! Please try again.",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "An error occurred. Please try again.",
      ));
    }
  }

  bool _meetsAllRequirements(String password) {
    if (password.isEmpty) return false;
    
    final bool hasMinLength = password.length >= 8;
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));

    return hasMinLength && hasUppercase && hasLowercase;
  }

  String _getPasswordRequirements(String password) {
    final bool hasMinLength = password.length >= 8;
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    
    final bool allRequirementsMet = hasMinLength && hasUppercase && hasLowercase;

    return "${allRequirementsMet ? '✓' : ''} Password requirements:\n"
           "${hasMinLength ? '✓' : '•'} Must be at least 8 characters long\n"
           "${hasUppercase ? '✓' : '•'} Must contain at least one uppercase letter\n"
           "${hasLowercase ? '✓' : '•'} Must contain at least one lowercase letter";
  }

  bool _isFormValid(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) return false;
    if (!_meetsAllRequirements(password)) return false;
    if (password != confirmPassword) return false;
    return true;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return null;
    return _meetsAllRequirements(password) ? null : _getPasswordRequirements(password);
  }
}
