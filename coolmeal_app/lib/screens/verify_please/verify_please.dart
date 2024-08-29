import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyPlease extends StatefulWidget {
  const VerifyPlease({super.key});

  @override
  State<VerifyPlease> createState() => _VerifyPleaseState();
}

class _VerifyPleaseState extends State<VerifyPlease> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Logo.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              'Please Verify Your Email!',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
