import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'or',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
