part of 'email_bloc.dart';

abstract class EmailState {}

class EmailInitial extends EmailState {}

class EmailValid extends EmailState {
  final String email;

  EmailValid(this.email);
}

class EmailError extends EmailState {
  final String error;

  EmailError(this.error);
}
