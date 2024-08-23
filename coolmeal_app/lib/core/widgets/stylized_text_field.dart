import 'package:flutter/material.dart';

class StylizedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool autocorrect;
  final bool enableSuggestions;
  final Color labelColor;
  final Color fillColor;
  final Color focusedBorderColor;
  final bool obscureText;
  final Color enabledBorderColor;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const StylizedTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.autocorrect = false,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.labelColor = const Color(0xFF9A9EA4),
    this.fillColor = const Color(0xFFF2F4F5),
    this.focusedBorderColor = const Color(0xFF036D59),
    this.enabledBorderColor = Colors.transparent,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: autocorrect,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      enableSuggestions: enableSuggestions,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: labelColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: focusedBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(color: enabledBorderColor),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor,
      ),
    );
  }
}