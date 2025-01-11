import 'package:confident_voice/views/screens/signup/email.dart';
import 'package:flutter/material.dart';
import 'package:confident_voice/views/screens/homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confident_voice/controllers/login-bloc/login_bloc.dart';
import 'package:confident_voice/controllers/login-bloc/login_event.dart';
import 'package:confident_voice/controllers/login-bloc/login_state.dart';
import 'package:confident_voice/views/screens/auth/forgot_password.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Login Failed"),
                  content: Text(state.errorMessage!),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/logo2.png',
                            height: 250,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(EmailChanged(value)),
                              decoration: InputDecoration(
                                labelText: "Email",
                                hintText: "Enter your email",
                                errorText: state.emailError,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              onChanged: (value) => context
                                  .read<LoginBloc>()
                                  .add(PasswordChanged(value)),
                              decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "Enter your password",
                                errorText: state.passwordError,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color(0xFFA26DC5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            state.isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: state.isValid
                                        ? () => context
                                            .read<LoginBloc>()
                                            .add(LoginSubmitted())
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF412963),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Log in",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Do not have an account? ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Email()),
                                    );
                                  },
                                  child: const Text(
                                    "Sign up",
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
