// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, no_leading_underscores_for_local_identifiers, non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'goal_setting_screen.dart';
import 'workout_screen.dart';
import 'step_entry_screen.dart';
import 'progress_entry_screen.dart'; // Add this import
import 'progress_report_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Fetch user details from Firestore
  Future<Map<String, dynamic>> getUserDetails(String userId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    String getGreeting() {
      int hour = DateTime.now().hour;
      if (hour < 12) {
        return "Good Morning";
      } else if (hour < 18) {
        return "Good Afternoon";
      } else {
        return "Good Evening";
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Fitness Tracker'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettings(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: getUserDetails(currentUser?.uid ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching user details'));
                  }
                  final userDetails = snapshot.data ?? {};
                  String userName = userDetails['name'] ?? 'User';
                  return Text(
                    '${getGreeting()}, $userName!',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Daily Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser?.uid)
                    .collection('goals')
                    .doc('dailyGoals')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>?;
                    int stepGoal = data?['stepGoal'] ?? 0;
                    int calorieGoal = data?['calorieGoal'] ?? 0;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildGoalCard(context, 'Steps', stepGoal, Colors.blue, screenWidth),
                        _buildGoalCard(context, 'Calories', calorieGoal, Colors.red, screenWidth),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading goals'));
                  } else {
                    return const Center(child: Text('No goals set'));
                  }
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(221, 250, 249, 249),
                ),
              ),
              const SizedBox(height: 10),
             Wrap(
              alignment: WrapAlignment.center,
              spacing: 20.0,
              runSpacing: 20.0,
              children: [
                _buildActionButton(
                  context,
                  'Set Goal',
                  'Define your daily fitness goals', 
                  GoalSettingScreen(),
                  screenWidth,
                  Icons.calendar_today // Icon for Set Goal
                ),
                _buildActionButton(
                  context, 
                  'Add Workout',
                  'Log a new workout session', 
                  WorkoutScreen(),
                  screenWidth,
                  Icons.fitness_center // Icon for Add Workout
                ),
                _buildActionButton(
                  context,
                  'Log Steps', 
                  'Record your daily step count',
                  StepEntryScreen(),
                  screenWidth,
                  Icons.directions_walk // Icon for Log Steps
                ),
                _buildActionButton(
                  context, 
                  'Update Progress',
                  'View or update your progress', 
                  ProgressEntryScreen(),
                  screenWidth,
                  Icons.trending_up // Icon for Update Progress
                ),
              ],
            ),

              const SizedBox(height: 30),
              const Text(
                'Progress Report',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProgressReportScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('View Detailed Progress Report'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Recent Activities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser?.uid)
                      .collection('workouts')
                      .orderBy('workoutName')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var workouts = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: workouts.length,
                        itemBuilder: (context, index) {
                          var workout = workouts[index].data() as Map<String, dynamic>;
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.fitness_center, color: Colors.teal),
                              title: Text('${workout['workoutName']}'),
                              subtitle: Text('Duration(Mins): ${workout['duration']} mins, Calories(Kcal): ${workout['calories']}'),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No recent activities'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build goal card
  Widget _buildGoalCard(BuildContext context, String title, int goal, Color color, double screenWidth) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .collection('progress')
          .doc('dailyProgress')
          .snapshots(),
      builder: (context, snapshot) {
        int progress = 0;
        int progressPercentage = 0;

        if (snapshot.hasData && snapshot.data!.exists) {
          var progressData = snapshot.data!.data() as Map<String, dynamic>;
          progress = progressData['progress'] ?? 0;
          progressPercentage = (goal == 0) ? 0 : ((progress / goal) * 100).toInt();
        }

        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: screenWidth * 0.4,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_walk, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  '$progress / $goal',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                LinearProgressIndicator(
                  value: progressPercentage / 100,
                  color: color,
                  backgroundColor: color.withOpacity(0.2),
                ),
                const SizedBox(height: 8),
                Text(
                  '$progressPercentage%',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Widget to build action button
Widget _buildActionButton(BuildContext context, String label, String description, Widget screen, double screenWidth, IconData icon) {
  return SizedBox(
    width: screenWidth * 0.4, // Adjust button width based on screen size
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white), // Updated icon color
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white, // White text color
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white, // White text color
            ),
          ),
        ],
      ),
    ),
  );
}

  // Logout function
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Show Settings dialog with user details
  void _showSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('User Settings'),
          content: FutureBuilder<Map<String, dynamic>>(
            future: getUserDetails(currentUser?.uid ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Text('Error fetching user details');
              }
              final userDetails = snapshot.data ?? {};
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Names: ${userDetails['name'] ?? 'Not Available'}'),
                  Text('Email: ${userDetails['email'] ?? 'Not Available'}'),
                  Text('Phone: ${userDetails['phone'] ?? 'Not Available'}'),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}