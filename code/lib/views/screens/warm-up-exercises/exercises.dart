import 'package:flutter/material.dart';
import 'oneExercise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confident_voice/controllers/warm-up-exo-bloc/exercises_bloc.dart';

class Exercises extends StatelessWidget {
  const Exercises({super.key});

  void _navigateToExercise(
      BuildContext context, Map<String, dynamic> exercise) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OneExercise(
          exerciseTitle: exercise['title'],
          exerciseImage: exercise['imagePath'],
          exerciseDuration: exercise['duration'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExercisesBloc()..add(LoadExercisesEvent()),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Warm up",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Image.asset(
                  'assets/images/logo2.png',
                  height: 61,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ExercisesBloc, ExercisesState>(
                  builder: (context, state) {
                    if (state.exercises.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: state.exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = state.exercises[index];
                        return ExerciseCard(
                          title: exercise['title'],
                          duration: exercise['duration'],
                          progress: exercise['progress'],
                          imagePath: exercise['imagePath'],
                          onTap: () => _navigateToExercise(context, exercise),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String title;
  final String duration;
  final double progress;
  final String imagePath;
  final VoidCallback onTap;

  const ExerciseCard({
    super.key,
    required this.title,
    required this.duration,
    required this.progress,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF7F53A5),
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Image.asset(imagePath, width: 60, height: 60),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: const Color(0xFF5E2875),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
