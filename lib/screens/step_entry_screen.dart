// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StepEntryScreen extends StatefulWidget {
  @override
  _StepEntryScreenState createState() => _StepEntryScreenState();
}

class _StepEntryScreenState extends State<StepEntryScreen> {
  final TextEditingController _stepsController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> _logSteps() async {
    if (_stepsController.text.isNotEmpty) {
      String todayDate = DateTime.now().toIso8601String().split('T')[0];
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .collection('steps')
          .doc(todayDate)
          .set({
        'steps': int.parse(_stepsController.text),
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Steps logged successfully!'),
          backgroundColor: Colors.teal,
          duration: Duration(seconds: 2),
        ),
      );
      _stepsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Steps'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your step count for today:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _stepsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Steps',
                hintText: 'e.g., 10000',
                filled: true,
                fillColor: Colors.teal.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _logSteps,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Log Steps',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
