import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

Widget buildPhoneNumberInput({
  required TextEditingController controller,
}) {
  return InternationalPhoneNumberInput(
    onInputChanged: (PhoneNumber number) {
      // handle number change
    },
    textFieldController: controller,
    inputDecoration: const InputDecoration(
      labelText: 'Phone Number',
      border: OutlineInputBorder(),
    ),
  );
}
