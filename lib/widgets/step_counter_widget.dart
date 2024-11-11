import 'package:flutter/material.dart';

class StepCounterWidget extends StatelessWidget {
  final int steps;

  const StepCounterWidget({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Steps', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.directions_walk, size: 40, color: Colors.blue),
            const SizedBox(width: 10),
            Text('$steps', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
