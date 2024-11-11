import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveWorkout(workout) async {
    await firestore.collection('workouts').add(workout.toJson());
  }

  // Add more methods as needed
}
