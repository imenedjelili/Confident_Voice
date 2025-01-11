import 'package:flutter/material.dart';
import 'gender.dart';
import 'package:confident_voice/views/screens/login/login.dart';
import 'package:confident_voice/controllers/signup-bloc/birthday_bloc.dart';
import 'package:confident_voice/controllers/signup-bloc/birthday_event.dart';
import 'package:confident_voice/controllers/signup-bloc/birthday_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Birthday extends StatelessWidget {
  final String fullName;
  final String email;

  const Birthday({super.key, required this.fullName, required this.email});

  void _selectDate(BuildContext context) async {
    // Calculate the minimum date (16 years ago)
    final DateTime now = DateTime.now();
    final DateTime minDate = DateTime(now.year - 100);  // 100 years ago
    final DateTime maxDate = DateTime(now.year - 16, now.month, now.day);  // 16 years ago

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: maxDate,
      firstDate: minDate,
      lastDate: maxDate,
      helpText: 'Select your birth date (Must be at least 16 years old)',
    );

    if (selectedDate != null) {
      context.read<BirthdayBloc>().add(DateSelected(selectedDate));
    }
    }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BirthdayBloc(),
      child: BlocBuilder<BirthdayBloc, BirthdayState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "Hello, $fullName!",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Image.asset(
                          'assets/images/illustrationSign.png',
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text(
                        "Create account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 297,
                        height: 53,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            5,
                            (index) => Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: index <= 1
                                            ? const Color(0xFF412963)
                                            : Colors.grey.shade300,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    if (index <= 1)
                                      const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                  ],
                                ),
                                if (index < 4)
                                  Container(
                                    width: 36,
                                    height: 8,
                                    color: index <= 1
                                        ? const Color(0xFF412963)
                                        : Colors.grey.shade300,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Date of Birth:",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              controller: TextEditingController(
                                  text: state.selectedDate),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: "DD/MM/YYYY",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 14.0,
                                ),
                                errorText: state.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<BirthdayBloc>().add(ContinuePressed());
                            if (state.isValid) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Gender(email: email),
                                ),
                              );
                            }
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
                              "Continue",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sign up with Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/images/googleIcon.png',
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                color: Color(0xFF412963),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
