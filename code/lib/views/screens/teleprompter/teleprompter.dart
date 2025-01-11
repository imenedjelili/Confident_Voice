import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confident_voice/controllers/teleprompter-bloc/teleprompter_bloc.dart';

class Teleprompter extends StatelessWidget {
  final String text;

  const Teleprompter({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return BlocProvider(
      create: (_) => TeleprompterBloc(scrollController),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<TeleprompterBloc, TeleprompterState>(
          builder: (context, state) {
            final bloc = context.read<TeleprompterBloc>();

            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFF9A8B),
                    Color(0xFFFF6A88),
                    Color(0xFFFF99AC),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 100),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
                    child: Slider(
                      value: state.scrollSpeed,
                      min: 10.0,
                      max: 50.0,
                      activeColor: Colors.pinkAccent,
                      inactiveColor: Colors.white.withOpacity(0.5),
                      onChanged: (value) {
                        bloc.add(UpdateScrollSpeed(value));
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: state.isScrolling
                        ? () => bloc.add(StopScrolling())
                        : () => bloc.add(StartScrolling()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          state.isScrolling ? Colors.red : Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      state.isScrolling ? "Stop Scrolling" : "Start Scrolling",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
