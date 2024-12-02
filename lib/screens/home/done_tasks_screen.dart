import 'package:flutter/material.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archived'),
      ),
      body: const Center(
        child: Text(
          'This is the done screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
