import 'package:flutter/material.dart';

class RequirementItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const RequirementItem({super.key, required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: isValid ? const Color(0xFF036D59) : Colors.green.shade50,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
              color: isValid ? Colors.black54 : Colors.black38,
              fontSize: 14),
        ),
      ],
    );
  }
}
