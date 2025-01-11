import 'package:confident_voice/views/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'password.dart';

class Gender extends StatefulWidget {
  const Gender({super.key, required this.email});
  final String email;

  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String? _selectedGender = 'Select your gender';

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
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: index <= 2
                                    ? const Color(0xFF412963)
                                    : Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                            ),
                            if (index <= 2)
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
                            color: index <= 2
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
                      "Gender:",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedGender,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.deepPurple,
                        ),
                        iconSize: 28,
                        underline: Container(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGender = newValue;
                          });
                        },
                        items: <String>['Select your gender', 'Female', 'Male']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: value == 'Select your gender'
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Password(
                          email: widget.email,
                          fullName: 'Your Full Name', // Replace with actual full name
                          birthday: DateTime(2000, 1, 1), // Replace with actual DateTime object
                          gender: _selectedGender ?? 'Select your gender',
                        ),
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
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
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
                        MaterialPageRoute(builder: (context) => const Login()),
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
    );
  }
}
