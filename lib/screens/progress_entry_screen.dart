// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProgressEntryScreen extends StatefulWidget {
  @override
  _StepEntryScreenState createState() => _StepEntryScreenState();
}

class _StepEntryScreenState extends State<ProgressEntryScreen> {
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  final User? currentUser = FirebaseAuth.instance.currentUser;

  void _updateProgress() async {
    // Get the input data
    int steps = int.tryParse(_stepsController.text) ?? 0;
    int calories = int.tryParse(_caloriesController.text) ?? 0;

    // Reference to Firestore for the user's progress
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .collection('progress') // Access the 'progress' subcollection
        .doc('dailyProgress'); // Document for daily progress

    // Update progress for both steps and calories
    await userDocRef.set({
      'steps': steps,
      'calories': calories,
      'timestamp': FieldValue.serverTimestamp(), // Save the timestamp
    }, SetOptions(merge: true)); // Use merge to update existing data if any

    // After updating, show a confirmation message or navigate back
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Progress Updated")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Progress'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _stepsController,
              decoration: const InputDecoration(
                labelText: 'Steps',
                hintText: 'Enter the number of steps',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _caloriesController,
              decoration: const InputDecoration(
                labelText: 'Calories Burned',
                hintText: 'Enter the calories burnt',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProgress,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0)),
              child: const Text('Update Progress'),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0)),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
