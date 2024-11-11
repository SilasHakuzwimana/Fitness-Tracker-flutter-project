import 'package:flutter/material.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({required this.password});

  @override
  Widget build(BuildContext context) {
    double strength = calculatePasswordStrength(password);
    Color strengthColor = getStrengthColor(strength);
    String strengthText = getStrengthText(strength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: strength,
          backgroundColor: Colors.grey[300],
          color: strengthColor,
          minHeight: 10,
        ),
        const SizedBox(height: 5),
        Text(
          strengthText,
          style: TextStyle(color: strengthColor, fontSize: 16),
        ),
      ],
    );
  }

  double calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0;

    double strength = 0;
    if (password.length >= 8) strength += 0.2;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[!@#\$&*~]').hasMatch(password)) strength += 0.2;
    if (password.length >= 12) strength += 0.2; // Extra strength for longer passwords

    return strength;
  }

  Color getStrengthColor(double strength) {
    if (strength <= 0.2) return Colors.red;
    if (strength <= 0.4) return Colors.orange;
    if (strength <= 0.6) return Colors.yellow;
    if (strength <= 0.8) return Colors.lightGreen;
    return Colors.green; // Very Strong
  }

  String getStrengthText(double strength) {
    if (strength <= 0.2) return 'Weak';
    if (strength <= 0.4) return 'Fair';
    if (strength <= 0.6) return 'Good';
    if (strength <= 0.8) return 'Strong';
    return 'Best';
  }
}
