// birthday_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'birthday_state.dart';
import 'birthday_event.dart';

class BirthdayBloc extends Bloc<BirthdayEvent, BirthdayState> {
  BirthdayBloc() : super(BirthdayState()) {
    on<DateSelected>(_onDateSelected);
    on<ContinuePressed>(_onContinuePressed);
  }

  bool _isAtLeast16YearsOld(DateTime birthDate) {
    final today = DateTime.now();
    final difference = today.difference(birthDate);
    final age = difference.inDays / 365.25; // Using 365.25 to account for leap years
    return age >= 16;
  }

  void _onDateSelected(DateSelected event, Emitter<BirthdayState> emit) {
    if (!_isAtLeast16YearsOld(event.date)) {
      emit(state.copyWith(
        selectedDate: DateFormat('dd/MM/yyyy').format(event.date),
        isValid: false,
        error: "You must be at least 16 years old to use this app",
      ));
      return;
    }

    final formattedDate = DateFormat('dd/MM/yyyy').format(event.date);
    emit(state.copyWith(
      selectedDate: formattedDate,
      isValid: true,
      error: null,
    ));
  }

  void _onContinuePressed(ContinuePressed event, Emitter<BirthdayState> emit) {
    if (state.selectedDate == null || state.selectedDate!.isEmpty) {
      emit(state.copyWith(
        error: "Date of Birth is required",
        isValid: false,
      ));
    } else if (!state.isValid) {
      emit(state.copyWith(
        error: "You must be at least 16 years old to use this app",
        isValid: false,
      ));
    }
  }
}