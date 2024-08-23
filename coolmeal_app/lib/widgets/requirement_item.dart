import 'package:flutter/material.dart';

class RequirementItem extends StatelessWidget {
  final String text;
  final bool isValid;

  RequirementItem({required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isValid ? Colors.green : Colors.grey,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
