// birthday_event.dart
abstract class BirthdayEvent {}

class DateSelected extends BirthdayEvent {
  final DateTime date;
  DateSelected(this.date);
}

class ContinuePressed extends BirthdayEvent {}