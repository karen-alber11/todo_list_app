import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/routes/app_navigation_router.dart';
import '../../database/data.dart';
import '../../providers/user/user_provider.dart';
import 'package:uuid/uuid.dart';
import '../../config/routes/routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isSignUp = true;

  final UserDatasource _userDatasource = UserDatasource();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Login / Sign Up', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(isSignUp ? "Create an Account" : "Sign In",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            if (isSignUp) _buildTextField('Name', _nameController, Icons.person),
            const SizedBox(height: 20),
            _buildTextField('Email', _emailController, Icons.email),
            const SizedBox(height: 20),
            _buildTextField('Password', _passwordController, Icons.lock, obscureText: true),
            const SizedBox(height: 30),
            ElevatedButton(
              style: TextButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: isSignUp ? _signUp : _signIn,
              child: Text(isSignUp ? 'Sign Up' : 'Sign In', style: const TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignUp = !isSignUp;
                });
              },
              child: Text(
                isSignUp ? 'Already have an account? Sign In' : "Don't have an account? Sign Up",
                style: const TextStyle(color: Colors.orange),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _userDatasource.resetDatabase();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Database reset successfully")),
                );
              },
              child: const Text('Reset Database'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
    );
  }

  void _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorMessage("All fields are required.");
      return;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      _showErrorMessage("Please enter a valid email address.");
      return;
    }

    try {
      final existingUser = await _userDatasource.getUserByEmail(email);
      if (existingUser != null) {
        _showErrorMessage("Email already in use.");
        return;
      }

      final user = User(id: const Uuid().v4(), name: name, email: email, password: password);
      final success = await _userDatasource.createUser(user);

      if (success) {
        ref.read(currentUserProvider.notifier).state = user;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppRouter()));
      } else {
        _showErrorMessage("Sign up failed.");
      }
    } catch (e) {
      _showErrorMessage("Error: $e");
    }
  }

  void _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('Email: "$email", Password: "$password"'); // Debugging line

    if (email.isEmpty || password.isEmpty) {
      _showErrorMessage("Both fields are required.");
      return;
    }

    try {
      final user = await _userDatasource.getUserByEmail(email);

      if (user == null || user.password != password) {
        _showErrorMessage("Invalid email or password.");
        return;
      }

      ref.read(currentUserProvider.notifier).state = user;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppRouter()));
    } catch (e) {
      _showErrorMessage("Error: $e");
    }
  }


  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
