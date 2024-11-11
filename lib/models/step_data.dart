// TODO Implement this library.

class StepData {
  final int steps;
  final DateTime date;

  StepData({
    required this.steps,
    required this.date,
  });

  // Optionally, a method to convert steps to calories
  double get caloriesBurned => steps * 0.04; // Approximation
}
