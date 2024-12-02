import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../widgets/app_header.dart';
import '../../database/data.dart';
import '../../screens/auth/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the size of the device for the header
    final deviceSize = MediaQuery.of(context).size;
    final date = DateTime.now(); // Use the current date

    // Fetch current user data using Riverpod's currentUserProvider
    final currentUser = ref.watch(currentUserProvider);

    // Check if the current user is available
    if (currentUser == null) {
      // If no user is logged in, show a loading screen or an error message
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use AppHeader instead of AppBar
          AppHeader(
            deviceSize: deviceSize,
            date: date,
            ref: ref,
            title: 'Profile', // You can set the title here or pass it dynamically
          ),
          const SizedBox(height: 20), // Space between header and profile details

          // Display Name and Email
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${currentUser.name}', // Use currentUser's data
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ${currentUser.email}', // Use currentUser's email
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 40),
                // Logout Button
                ElevatedButton(
                  onPressed: () {
                    // Perform logout action here (clear user data)
                    ref.read(currentUserProvider.notifier).state = null; // Clear the current user
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen())); // Replace '/login' with your actual login route
                  },
                  child: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set background color to red for logout
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
