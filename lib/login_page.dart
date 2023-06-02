import 'package:flutter/material.dart';
import 'package:flutter_application_2/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Retrieve user data from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    if (email == storedEmail && password == storedPassword) {
      // Move to next screen (e.g., Home screen)
      navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
      //navigatorKey.currentState?.pushReplacementNamed('/home');
    } else {
      // Show snack bar with error message
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Invalid Credentials')),
      );
    }
  }
  void _navigateToSignup() {
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => _buildLoginPage());
      },
    );
  }

  Widget _buildLoginPage() {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () => _login(),
            ),
            TextButton(
              onPressed: _navigateToSignup,
              child: const Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
