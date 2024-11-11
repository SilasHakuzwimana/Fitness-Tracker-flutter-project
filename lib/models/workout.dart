import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutScreen extends StatelessWidget {
  final TextEditingController workoutNameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController calorieController = TextEditingController();

  Future<void> addWorkout() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userId = user.uid;
    final workoutName = workoutNameController.text;
    final duration = int.tryParse(durationController.text) ?? 0;
    final calories = int.tryParse(calorieController.text) ?? 0;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .add({
          'workoutName': workoutName,
          'duration': duration,
          'calories': calories,
          'timestamp': FieldValue.serverTimestamp(),
        });

    print('Workout added successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Workout')),
      body: Column(
        children: [
          TextField(
            controller: workoutNameController,
            decoration: const InputDecoration(hintText: 'Workout Name'),
          ),
          TextField(
            controller: durationController,
            decoration: const InputDecoration(hintText: 'Duration (mins)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: calorieController,
            decoration: const InputDecoration(hintText: 'Calories Burned'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(onPressed: addWorkout, child: const Text('Add Workout')),
        ],
      ),
    );
  }
}
