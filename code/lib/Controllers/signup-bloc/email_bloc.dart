import 'package:flutter_bloc/flutter_bloc.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailInitial()) {
    on<EmailSubmitted>((event, emit) {
      final email = event.email;
      if (email.isEmpty) {
        emit(EmailError("Email is required"));
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        emit(EmailError("Enter a valid email"));
      } else {
        emit(EmailValid(email));
      }
    });
  }
}
