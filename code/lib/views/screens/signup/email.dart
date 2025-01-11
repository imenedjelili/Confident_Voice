import 'package:flutter/material.dart';
import 'name.dart';
import 'package:confident_voice/views/screens/login/login.dart';
import 'package:confident_voice/controllers/signup-bloc/email_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Your Name page

class Email extends StatelessWidget {
  const Email({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmailBloc(),
      child: const EmailView(),
    );
  }
}

class EmailView extends StatefulWidget {
  const EmailView({super.key});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            child: BlocListener<EmailBloc, EmailState>(
              listener: (context, state) {
                if (state is EmailValid) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Name(email: state.email),
                    ),
                  );
                } else if (state is EmailError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
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
                              Container(
                                width: 30,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (index < 4)
                                Container(
                                  width: 36,
                                  height: 8,
                                  color: Colors.grey.shade300,
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
                            "Email",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: "Enter your email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 14.0),
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
                          context
                              .read<EmailBloc>()
                              .add(EmailSubmitted(_emailController.text));
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                                  builder: (context) => const Login()),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
