// name_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class NameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NameChanged extends NameEvent {
  final String name;
  
  NameChanged(this.name);
  
  @override
  List<Object> get props => [name];
}

class NameSubmitted extends NameEvent {
  final String name;
  
  NameSubmitted(this.name);
  
  @override
  List<Object> get props => [name];
}

// States
abstract class NameState extends Equatable {
  const NameState();
  
  @override
  List<Object?> get props => [];
}

class NameInitial extends NameState {}

class NameError extends NameState {
  final String error;
  
  const NameError(this.error);
  
  @override
  List<Object> get props => [error];
}

class NameValid extends NameState {}

// BLoC
class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc() : super(NameInitial()) {
    on<NameChanged>(_onNameChanged);
    on<NameSubmitted>(_onNameSubmitted);
  }

  void _onNameChanged(NameChanged event, Emitter<NameState> emit) {
    if (event.name.isEmpty) {
      emit(const NameError("Name cannot be empty"));
    } else {
      emit(NameValid());
    }
  }

  void _onNameSubmitted(NameSubmitted event, Emitter<NameState> emit) {
    if (event.name.trim().isEmpty) {
      emit(const NameError("Name cannot be empty"));
    } else {
      emit(NameValid());
    }
  }
}