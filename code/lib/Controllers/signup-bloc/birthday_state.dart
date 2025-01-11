// birthday_state.dart
class BirthdayState {
  final String? selectedDate;
  final bool isValid;
  final String? error;

  BirthdayState({
    this.selectedDate,
    this.isValid = false,
    this.error,
  });

  BirthdayState copyWith({
    String? selectedDate,
    bool? isValid,
    String? error,
  }) {
    return BirthdayState(
      selectedDate: selectedDate ?? this.selectedDate,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }
}