part of 'email_bloc.dart';

abstract class EmailEvent {}

class EmailSubmitted extends EmailEvent {
  final String email;

  EmailSubmitted(this.email);
}
