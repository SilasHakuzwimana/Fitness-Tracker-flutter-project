import 'package:flutter/material.dart';

class WorkoutTile extends StatelessWidget {
  final String workoutName;
  final String workoutDetails;

  const WorkoutTile({required this.workoutName, required this.workoutDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.fitness_center),
        title: Text(workoutName),
        subtitle: Text(workoutDetails),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Navigate to workout details
        },
      ),
    );
  }
}
