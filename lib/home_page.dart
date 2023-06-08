import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/login_page.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickedFile? _image;
  bool _showConfirmation = false;

  Future _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = PickedFile(image.path);
        _showConfirmation = true;
      });
    }
  }

  void _logout(BuildContext context) {
    // Perform logout operation
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, // Customize your light mode theme color
    // Add other light mode theme configurations
  );

  return Theme(
    data: lightTheme,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Happy Animal'),
      ),
      body: Stack(
        children: [
          if (_image != null)
            Positioned.fill(
              child: Center(
                child: Image.asset(
                  "assets/images/plate4.jpg", // Image of eating plate
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (_image != null)
            Positioned.fill(
              child: Center(
                child: ClipOval(
                  child: Image.file(
                    File(_image!.path),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (_image != null)
            Positioned(
              top: kToolbarHeight - 50.0,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  "assets/images/animal1.jpg", // Image of the animal
                  width: 400,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    _getImageFromCamera();
                  },
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.camera_alt,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _showConfirmation ? 'Will you eat this?' : 'Click your meal',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () {
          _logout(context);
        },
      ),
    ),
  );
 }
}
