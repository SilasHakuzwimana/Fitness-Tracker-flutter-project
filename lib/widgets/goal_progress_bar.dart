import 'package:flutter/material.dart';

class GoalProgressBar extends StatelessWidget {
  final double progress;

  const GoalProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Goal Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
          minHeight: 10,
        ),
        const SizedBox(height: 5),
        Text('${(progress * 100).toStringAsFixed(1)}%', style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
