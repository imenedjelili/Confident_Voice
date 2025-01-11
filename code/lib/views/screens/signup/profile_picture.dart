import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:confident_voice/views/screens/homepage.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.email,
    required this.fullName,
    required this.birthday,
    required this.gender,
  });

  final String email;
  final String fullName;
  final DateTime birthday;
  final String gender;

  @override
  Widget build(BuildContext context) {
    return _ProfilePictureView(
      email: email,
      fullName: fullName,
      birthday: birthday,
      gender: gender,
    );
  }
}

class _ProfilePictureView extends StatefulWidget {
  const _ProfilePictureView({
    required this.email,
    required this.fullName,
    required this.birthday,
    required this.gender,
  });

  final String email;
  final String fullName;
  final DateTime birthday;
  final String gender;

  @override
  _ProfilePictureViewState createState() => _ProfilePictureViewState();
}

class _ProfilePictureViewState extends State<_ProfilePictureView> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _continueToNextStep() {
    // Here you would typically save the profile picture
    // For now, we'll just navigate to the homepage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

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
      body: SingleChildScrollView(
        child: SafeArea(
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
                                      color: index < 6
                                          ? const Color(0xFF412963)
                                          : Colors.grey.shade300,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  if (index < 6)
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
                                    color: index < 6
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
                const SizedBox(height: 40),
                const Text(
                  "Add a profile picture",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _image == null
                        ? const Icon(
                            Icons.add_a_photo,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "This step is optional",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _continueToNextStep,
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _continueToNextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
    );
  }
}
