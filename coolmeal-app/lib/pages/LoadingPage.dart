import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  State<Loadingpage> createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage> {
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
              'Welcome to a Healthier You!',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 20,
                ),
              ),

              // ),
            ),
          ],
        ),
      ),
    );
  }
}
