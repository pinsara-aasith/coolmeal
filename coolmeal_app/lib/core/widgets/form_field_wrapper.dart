import 'package:flutter/material.dart';

class FormFieldWrapper extends StatelessWidget {
  final String label;
  final Widget textField;

  const FormFieldWrapper({
    Key? key,
    required this.label,
    required this.textField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 5),
        textField,
      ],
    );
  }
}
