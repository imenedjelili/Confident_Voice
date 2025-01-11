// new_script_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'scripts.dart';
import 'package:confident_voice/controllers/teleprompter-bloc/new_script_bloc.dart';

class NewScript extends StatelessWidget {
  NewScript({super.key});

  final TextEditingController topicController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewScriptBloc(),
      child: BlocBuilder<NewScriptBloc, NewScriptState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 10,
                            width: 150,
                            color: const Color(0xFFCB96C2),
                          ),
                          const Text(
                            "Let's Do it :",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: topicController,
                      onChanged: (value) {
                        context.read<NewScriptBloc>().add(TopicChanged(value));
                      },
                      decoration: InputDecoration(
                        hintText: "Topic...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        errorText: state.errorMessage,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: descriptionController,
                      onChanged: (value) {
                        context
                            .read<NewScriptBloc>()
                            .add(DescriptionChanged(value));
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Description...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.chat_bubble_outline,
                                    color: Colors.orangeAccent),
                                SizedBox(width: 8),
                                Text(
                                  "Get help from AI",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              'assets/images/iaHelp.png',
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            context
                                .read<NewScriptBloc>()
                                .add(ScriptSubmitted());
                            if (state.isValid) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scripts(
                                    newScript: descriptionController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          backgroundColor: const Color(0xFF412963),
                          elevation: 6,
                          shape: const CircleBorder(),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
