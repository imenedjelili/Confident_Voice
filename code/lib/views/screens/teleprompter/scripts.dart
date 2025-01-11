// scripts_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'teleprompter.dart';
import 'newScript.dart';
import 'package:confident_voice/controllers/teleprompter-bloc/scripts_bloc.dart';

class Scripts extends StatelessWidget {
  final String? newScript;

  const Scripts({super.key, this.newScript});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ScriptsBloc()..add(LoadScripts());
        if (newScript != null) {
          bloc.add(AddNewScript(newScript!));
        }
        return bloc;
      },
      child: BlocBuilder<ScriptsBloc, ScriptsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Confident ",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.purple,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/logo2.png',
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Text(
                            " Voice",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 15,
                            width: 250,
                            color: const Color(0xFFCB96C2),
                          ),
                          const Text(
                            "Teleprompter",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 190, bottom: 16.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 15,
                        width: 250,
                        color: const Color(0xFFCB96C2),
                      ),
                      const Text(
                        "Your Recent Scripts:",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state.error != null)
                  Center(child: Text(state.error!))
                else
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.6,
                        ),
                        itemCount: state.scripts.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Teleprompter(
                                    text: state.scripts[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                state.scripts[index],
                                style:
                                    const TextStyle(fontSize: 16, height: 1.6),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 16.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewScript(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF412963),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Create new script",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
