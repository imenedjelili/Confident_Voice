// new_script_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class NewScriptEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopicChanged extends NewScriptEvent {
  final String topic;
  
  TopicChanged(this.topic);
  
  @override
  List<Object?> get props => [topic];
}

class DescriptionChanged extends NewScriptEvent {
  final String description;
  
  DescriptionChanged(this.description);
  
  @override
  List<Object?> get props => [description];
}

class ScriptSubmitted extends NewScriptEvent {}

// States
class NewScriptState extends Equatable {
  final String topic;
  final String description;
  final bool isValid;
  final String? errorMessage;
  
  const NewScriptState({
    this.topic = '',
    this.description = '',
    this.isValid = false,
    this.errorMessage,
  });
  
  NewScriptState copyWith({
    String? topic,
    String? description,
    bool? isValid,
    String? errorMessage,
  }) {
    return NewScriptState(
      topic: topic ?? this.topic,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [topic, description, isValid, errorMessage];
}

// Bloc
class NewScriptBloc extends Bloc<NewScriptEvent, NewScriptState> {
  NewScriptBloc() : super(const NewScriptState()) {
    on<TopicChanged>(_onTopicChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<ScriptSubmitted>(_onScriptSubmitted);
  }
  
  void _onTopicChanged(TopicChanged event, Emitter<NewScriptState> emit) {
    final newState = state.copyWith(
      topic: event.topic,
      isValid: event.topic.isNotEmpty && state.description.isNotEmpty,
    );
    emit(newState);
  }
  
  void _onDescriptionChanged(DescriptionChanged event, Emitter<NewScriptState> emit) {
    final newState = state.copyWith(
      description: event.description,
      isValid: state.topic.isNotEmpty && event.description.isNotEmpty,
    );
    emit(newState);
  }
  
  void _onScriptSubmitted(ScriptSubmitted event, Emitter<NewScriptState> emit) {
    if (!state.isValid) {
      emit(state.copyWith(
        errorMessage: 'Please fill in both topic and description',
      ));
      return;
    }
    // Here you can add additional logic for submission
    // For now, we'll just clear the error message if any
    emit(state.copyWith(errorMessage: null));
  }
}