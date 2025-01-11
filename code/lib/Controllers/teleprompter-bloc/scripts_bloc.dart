// scripts_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ScriptsEvent extends Equatable {
  const ScriptsEvent();

  @override
  List<Object?> get props => [];
}

class LoadScripts extends ScriptsEvent {}

class AddNewScript extends ScriptsEvent {
  final String script;

  const AddNewScript(this.script);

  @override
  List<Object?> get props => [script];
}

// States
class ScriptsState extends Equatable {
  final List<String> scripts;
  final bool isLoading;
  final String? error;

  const ScriptsState({
    this.scripts = const [],
    this.isLoading = false,
    this.error,
  });

  ScriptsState copyWith({
    List<String>? scripts,
    bool? isLoading,
    String? error,
  }) {
    return ScriptsState(
      scripts: scripts ?? this.scripts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [scripts, isLoading, error];
}

// Bloc
class ScriptsBloc extends Bloc<ScriptsEvent, ScriptsState> {
  ScriptsBloc() : super(const ScriptsState()) {
    on<LoadScripts>(_onLoadScripts);
    on<AddNewScript>(_onAddNewScript);
  }

  final List<String> _initialScripts = [
    "Public speaking can be intimidating, but with the right techniques...",
    "Imagine a world where renewable energy powers every home...",
    "Mental health is as important as physical health...",
    "The universe is vast and mysterious...",
    "Good nutrition is the cornerstone of a healthy life...",
    "In the digital age, cybersecurity is crucial..."
  ];

  void _onLoadScripts(LoadScripts event, Emitter<ScriptsState> emit) {
    emit(state.copyWith(isLoading: true));
    try {
      emit(state.copyWith(
        scripts: List.from(_initialScripts),
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load scripts',
        isLoading: false,
      ));
    }
  }

  void _onAddNewScript(AddNewScript event, Emitter<ScriptsState> emit) {
    final currentScripts = List<String>.from(state.scripts);
    currentScripts.add(event.script);
    emit(state.copyWith(scripts: currentScripts));
  }
}