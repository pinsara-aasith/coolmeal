import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Forget Your Password?',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.lightGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
