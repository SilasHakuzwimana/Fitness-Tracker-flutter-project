import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatelessWidget {
  final String email;

  const SettingsScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'User Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text('Name: ${userData['name']}', style: const TextStyle(fontSize: 18)),
                Text('Email: ${userData['email']}', style: const TextStyle(fontSize: 18)),
                Text('Weight: ${userData['weight'] ?? 'N/A'} kg', style: const TextStyle(fontSize: 18)),
                Text('Height: ${userData['height'] ?? 'N/A'} m', style: const TextStyle(fontSize: 18)),
                Text('Goal: ${userData['goal'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                Text('Activity Level: ${userData['activityLevel'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
