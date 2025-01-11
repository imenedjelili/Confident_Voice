import 'package:confident_voice/views/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confident_voice/controllers/signup-bloc/password_bloc.dart';
import 'package:confident_voice/controllers/signup-bloc/password_event.dart';
import 'package:confident_voice/controllers/signup-bloc/password_state.dart';
import 'profile_picture.dart';

class Password extends StatelessWidget {
  final String email;
  final String fullName;
  final DateTime birthday;
  final String gender;

  const Password({
    super.key,
    required this.email,
    required this.fullName,
    required this.birthday,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordBloc(email: email),
      child: BlocConsumer<PasswordBloc, PasswordState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePicture(
                  email: email,
                  fullName: fullName,
                  birthday: birthday,
                  gender: gender,
                ),
              ),
            );
          }
        },
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          "Create Account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 53,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                6,
                                (index) => Expanded(
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: index < 5
                                                  ? const Color(0xFF412963)
                                                  : Colors.grey.shade300,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          if (index < 5)
                                            const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                        ],
                                      ),
                                      if (index < 5)
                                        Expanded(
                                          child: Container(
                                            height: 8,
                                            color: index < 5
                                                ? const Color(0xFF412963)
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildPasswordField(
                          context: context,
                          hintText: "Password",
                          errorText: state.passwordError,
                          onChanged: (value) => context
                              .read<PasswordBloc>()
                              .add(PasswordChanged(value)),
                        ),
                        const SizedBox(height: 20),
                        _buildPasswordField(
                          context: context,
                          hintText: "Confirm Password",
                          errorText: state.confirmPasswordError,
                          onChanged: (value) => context
                              .read<PasswordBloc>()
                              .add(ConfirmPasswordChanged(value)),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: state.isValid && !state.isLoading
                              ? () =>
                                  context.read<PasswordBloc>().add(SubmitForm())
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF412963),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Center(
                            child: state.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Finish",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 10),
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
          );
        },
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required String hintText,
    required Function(String) onChanged,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: true,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 14.0,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: errorText.contains('\n')
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: errorText.split('\n').map((line) {
                      return Text(
                        line,
                        style: TextStyle(
                          color: line.startsWith('✓') ? Colors.green : Colors.red,
                          fontSize: 12.0,
                        ),
                      );
                    }).toList(),
                  )
                : Text(
                    errorText,
                    style: TextStyle(
                      color: errorText.startsWith('✓') ? Colors.green : Colors.red,
                      fontSize: 12.0,
                    ),
                  ),
          ),
      ],
    );
  }
}
