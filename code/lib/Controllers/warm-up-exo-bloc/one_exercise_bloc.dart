import 'package:flutter_bloc/flutter_bloc.dart';

class OneExerciseEvent {}

class NextStepEvent extends OneExerciseEvent {}

class PreviousStepEvent extends OneExerciseEvent {}

class ToggleCompletionEvent extends OneExerciseEvent {}

class OneExerciseState {
  final int currentStep;
  final bool isStepCompleted;

  OneExerciseState({required this.currentStep, required this.isStepCompleted});
}

class OneExerciseBloc extends Bloc<OneExerciseEvent, OneExerciseState> {
  final List<String> exerciseSteps;

  OneExerciseBloc(this.exerciseSteps)
      : super(OneExerciseState(currentStep: 0, isStepCompleted: false)) {
    on<NextStepEvent>((event, emit) {
      if (state.currentStep < exerciseSteps.length - 1) {
        emit(OneExerciseState(
          currentStep: state.currentStep + 1,
          isStepCompleted: false,
        ));
      }
    });

    on<PreviousStepEvent>((event, emit) {
      if (state.currentStep > 0) {
        emit(OneExerciseState(
          currentStep: state.currentStep - 1,
          isStepCompleted: false,
        ));
      }
    });

    on<ToggleCompletionEvent>((event, emit) {
      emit(OneExerciseState(
        currentStep: state.currentStep,
        isStepCompleted: !state.isStepCompleted,
      ));
    });
  }
}
