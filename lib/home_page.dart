import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;
  PickedFile? _image;
  String? _location;

  Future _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = PickedFile(image.path);
      });
    }
  }

  Future _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _location =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    });
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

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple, // Customize your dark mode theme color
      // Add other dark mode theme configurations
    );

    return Theme(
      data: isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Camera & Location Demo'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _getImageFromCamera();
                _getCurrentLocation();
              },
              child: const Text('Check-in'),
            ),
            const SizedBox(height: 16.0),
            if (_image != null)
              Image.file(
                File(_image!.path),
                width: 200,
                height: 200,
              ),
            if (_location != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _location!,
                  style: const TextStyle(fontSize: 16.0),
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
