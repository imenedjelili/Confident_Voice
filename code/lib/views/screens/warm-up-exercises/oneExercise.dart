import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confident_voice/controllers/warm-up-exo-bloc/one_exercise_bloc.dart';

class OneExercise extends StatelessWidget {
  final String exerciseTitle;
  final String exerciseImage;
  final String exerciseDuration;

  OneExercise({
    super.key,
    required this.exerciseTitle,
    required this.exerciseImage,
    required this.exerciseDuration,
  });

  final List<String> exerciseSteps = [
    "🧘‍♀️ Take a deep breath.",
    "😊 Smile widely to relax facial muscles.",
    "💃 Move your cheeks in small circular motions.",
    "👋 Tap your face lightly with your palms.",
    "🤸‍♂️ Gently stretch your face side to side.",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OneExerciseBloc(exerciseSteps),
      child: Scaffold(
        backgroundColor: const Color(0xFF412963),
        appBar: AppBar(
          backgroundColor: const Color(0xFF412963),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                exerciseTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                exerciseImage,
                height: 270,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),
              Text(
                exerciseDuration,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA26DC5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: BlocBuilder<OneExerciseBloc, OneExerciseState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                state.currentStep < exerciseSteps.length
                                    ? exerciseSteps[state.currentStep]
                                    : "Exercise Completed!",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: state.currentStep > 0
                                    ? () {
                                        context
                                            .read<OneExerciseBloc>()
                                            .add(PreviousStepEvent());
                                      }
                                    : null, // Disable button if at the first step
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF412963),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "⬅️ Previous",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: state.currentStep <
                                        exerciseSteps.length - 1
                                    ? () {
                                        context
                                            .read<OneExerciseBloc>()
                                            .add(NextStepEvent());
                                      }
                                    : null, // Disable button if at the last step
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF412963),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "➡️ Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<OneExerciseBloc>()
                                  .add(ToggleCompletionEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.isStepCompleted
                                  ? Colors.green
                                  : Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.isStepCompleted
                                    ? "✅ Completed"
                                    : "❌ Complete",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
