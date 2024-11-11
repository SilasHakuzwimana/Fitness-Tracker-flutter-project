import 'package:fitness_tracker/screens/about_us_screen.dart';
import 'package:fitness_tracker/screens/contact_screen.dart';
import 'package:fitness_tracker/screens/home_screen.dart';
import 'package:fitness_tracker/screens/progress_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:fitness_tracker/screens/login_screen.dart';
import 'package:fitness_tracker/screens/dashboard_screen.dart';
import 'package:fitness_tracker/screens/forgot_password_screen.dart';
import 'package:fitness_tracker/screens/otp_verification_screen.dart';
import 'package:fitness_tracker/screens/settings_screen.dart';
import 'package:fitness_tracker/screens/update_password_screen.dart';
import 'package:fitness_tracker/providers/step_provider.dart';
import 'package:fitness_tracker/services/notification_service.dart';
import 'package:fitness_tracker/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Notification Service
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  runApp(FitnessTrackerApp(notificationService: notificationService));
}

class FitnessTrackerApp extends StatelessWidget {
  final NotificationService notificationService;

  const FitnessTrackerApp({required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StepProvider()),
      ],
      child: MaterialApp(
        title: 'Fitness Tracker',
        theme: ThemeData(
          fontFamily: 'NotoSans', // Global font family
          primarySwatch: Colors.teal,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
            titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.teal,
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'NotoSans',
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/about-us': (context) => AboutUsScreen(),
          '/contact': (context) => ContactScreen(),
          '/login': (context) => LoginScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          '/otp-verification': (context) => const OtpVerificationScreen(email: '', phoneNumber: ''),
          '/update-password': (context) => UpdatePasswordScreen(),
          '/settings': (context) => const SettingsScreen(email: ''),
          '/progressReport': (context) => const ProgressReportScreen(),
        },
      ),
    );
  }
}
