import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesEvent {}

class LoadExercisesEvent extends ExercisesEvent {}

class ExercisesState {
  final List<Map<String, dynamic>> exercises;

  ExercisesState({required this.exercises});
}

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  ExercisesBloc() : super(ExercisesState(exercises: [])) {
    on<LoadExercisesEvent>((event, emit) {
      // Load exercises data
      final exercises = [
        {
          'title': 'Deep Breathing',
          'duration': '5 minutes',
          'progress': 0.7,
          'imagePath': 'assets/images/exo1.png',
        },
        {
          'title': 'Resonance Tone-Ups',
          'duration': '5 minutes',
          'progress': 0.5,
          'imagePath': 'assets/images/exo2.png',
        },
        {
          'title': 'Facial Warm-ups',
          'duration': '5 minutes',
          'progress': 0.3,
          'imagePath': 'assets/images/exo3.png',
        },
        {
          'title': 'Vocal Exercises',
          'duration': '7 minutes',
          'progress': 0.8,
          'imagePath': 'assets/images/exo1.png',
        },
        {
          'title': 'Breathing with Rhythm',
          'duration': '6 minutes',
          'progress': 0.6,
          'imagePath': 'assets/images/exo2.png',
        },
      ];
      emit(ExercisesState(exercises: exercises));
    });
  }
}