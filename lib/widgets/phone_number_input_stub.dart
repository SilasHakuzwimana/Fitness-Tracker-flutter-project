import 'package:flutter/material.dart';

Widget buildPhoneNumberInput({
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    decoration: const InputDecoration(
      labelText: 'Phone Number',
      border: OutlineInputBorder(),
    ),
  );
}
