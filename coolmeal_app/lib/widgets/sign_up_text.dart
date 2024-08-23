import 'package:coolmeal/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpTextWidget extends StatelessWidget {
  const SignUpTextWidget({super.key});

  //method for handle signup text pressed
  void handleSignUp(BuildContext context) {
    // Navigate to Sign Up page
    Navigator.pushNamed(context, Routes.signupScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Don't have an account? ",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(color: Colors.black),
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'Sign Up',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => handleSignUp(context),
            ),
          ],
        ),
      ),
    );
  }
}
