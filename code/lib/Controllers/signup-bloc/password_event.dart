// password_event.dart
abstract class PasswordEvent {}

class PasswordChanged extends PasswordEvent {
  final String password;
  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends PasswordEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class SubmitForm extends PasswordEvent {}