// ignore_for_file: avoid_print, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ProgressReportScreen extends StatefulWidget {
  const ProgressReportScreen({Key? key}) : super(key: key);

  @override
  _ProgressReportScreenState createState() => _ProgressReportScreenState();
}

class _ProgressReportScreenState extends State<ProgressReportScreen> {
  List<charts.Series<dynamic, String>> seriesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProgress();
  }

  Future<void> _fetchUserProgress() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("No user is currently logged in.");
      setState(() {
        isLoading = false;
      });
      return;
    }

    final userId = user.uid;

    try {
      // Fetch daily goals for steps and calories
      final dailyGoalsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('goals')
          .doc('dailyGoals')
          .get();

      if (!dailyGoalsSnapshot.exists) {
        print("No daily goals found.");
        setState(() {
          isLoading = false;
        });
        return;
      }

      final stepGoal = dailyGoalsSnapshot.data()?['stepGoal'] ?? 0;
      final calorieGoal = dailyGoalsSnapshot.data()?['calorieGoal'] ?? 0;

      // Fetch daily progress (steps and calories)
      final progressDataSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('progress')
          .doc('dailyProgress')
          .get();

      if (!progressDataSnapshot.exists) {
        print("No daily progress data found.");
        setState(() {
          isLoading = false;
        });
        return;
      }

      final progressData = progressDataSnapshot.data();
      final stepData = <ProgressData>[];
      final calorieData = <ProgressData>[];

      // Convert progress data to ProgressData list
      if (progressData != null) {
        final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

        // Add step data
        if (progressData['steps'] is Map<String, dynamic>) {
          (progressData['steps'] as Map<String, dynamic>).forEach((date, value) {
            if (value is int) {
              stepData.add(ProgressData(
                date: dateFormat.format(DateTime.parse(date)),
                value: value,
              ));
            }
          });
        }

        // Add calorie data
        if (progressData['calories'] is Map<String, dynamic>) {
          (progressData['calories'] as Map<String, dynamic>).forEach((date, value) {
            if (value is int) {
              calorieData.add(ProgressData(
                date: dateFormat.format(DateTime.parse(date)),
                value: value,
              ));
            }
          });
        }
      }

      // Update the seriesList with the data
      setState(() {
        seriesList = [
          charts.Series<ProgressData, String>(
            id: 'Steps',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (ProgressData progress, _) => progress.date,
            measureFn: (ProgressData progress, _) => progress.value,
            data: stepData,
          ),
          charts.Series<ProgressData, String>(
            id: 'Calories',
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
            domainFn: (ProgressData progress, _) => progress.date,
            measureFn: (ProgressData progress, _) => progress.value,
            data: calorieData,
          ),
        ];
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching progress data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Report'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : (seriesList.isEmpty
                ? const Text('No progress data available')
                : charts.BarChart(
                    seriesList,
                    animate: true,
                    animationDuration: const Duration(milliseconds: 2500),
                    behaviors: [
                      charts.SeriesLegend(
                        position: charts.BehaviorPosition.bottom,
                      ),
                    ],
                  )),
      ),
    );
  }
}

class ProgressData {
  final String date;
  final int value;

  ProgressData({required this.date, required this.value});
}
