class Goal {
  final int stepGoal;
  final int calorieGoal;

  Goal({
    required this.stepGoal,
    required this.calorieGoal,
  });

  // Convert Goal instance to JSON format for Firestore
  Map<String, dynamic> toJson() {
    return {
      'stepGoal': stepGoal,
      'calorieGoal': calorieGoal,
      'createdAt': DateTime.now(), // Optional: add timestamp
    };
  }
}
