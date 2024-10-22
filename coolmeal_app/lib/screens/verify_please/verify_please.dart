import 'package:coolmeal/helpers/extensions.dart';
import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              'assets/images/logo.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              'Please Verify Your Email!',
              style: GoogleFonts.lato(
                textStyle: TextStyles.font24Blue700Weight,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.currentUser?.reload();
                if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
                  context.pushNamedAndRemoveUntil(
                    Routes.loginScreen,
                    predicate: (route) => false,
                  );
                }
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text(
                'Check Again!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
