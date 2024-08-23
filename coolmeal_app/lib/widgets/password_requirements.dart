import 'package:coolmeal/widgets/requirement_item.dart';
import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  final bool hasSpecialCharacter;
  final bool hasNumber;
  final bool hasUpperCase;
  final bool isPasswordLengthValid;

  PasswordRequirements({
    required this.hasSpecialCharacter,
    required this.hasNumber,
    required this.hasUpperCase,
    required this.isPasswordLengthValid,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your password should contain',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        RequirementItem(
          text: '1 or more special characters',
          isValid: hasSpecialCharacter,
        ),
        RequirementItem(
          text: '1 or more numbers',
          isValid: hasNumber,
        ),
        RequirementItem(
          text: '1 upper case letter',
          isValid: hasUpperCase,
        ),
        RequirementItem(
          text: 'Between 8 and 20 characters',
          isValid: isPasswordLengthValid,
        ),
      ],
    );
  }
}
