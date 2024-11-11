import 'package:flutter/material.dart';

class WorkoutLoggingScreen extends StatelessWidget {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Workout')),
      body: Column(
        children: [
          TextField(controller: typeController, decoration: const InputDecoration(hintText: 'Workout Type')),
          TextField(controller: durationController, decoration: const InputDecoration(hintText: 'Duration (min)')),
          ElevatedButton(
            onPressed: () {
              // Handle workout logging
            },
            child: const Text('Save Workout'),
          ),
        ],
      ),
    );
  }
}
