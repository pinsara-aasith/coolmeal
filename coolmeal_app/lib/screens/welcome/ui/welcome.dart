import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<WelcomePage> {
  void handleSignUp() {
    Navigator.pushNamed(context, Routes.signupScreen);
  }

  void handleLogin() {
    Navigator.pushNamed(context, Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: welcomeGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    'assets/images/Logo.png',
                    height: 140,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Abroad!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.10),
                      child: Text(
                        'Join Us and Start Your Journey to Healthier Meals!',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      )),
                ],
              ),
              // Illustration Image
              Image.asset(
                'assets/images/conversation.png',
                height: 300,
              ),

              // Sign Up and Login Buttons
              Column(
                children: [
                  ElevatedButton(
                    onPressed: handleSignUp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize:
                          const Size(double.infinity, 50), // Full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: handleLogin,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                      minimumSize:
                          const Size(double.infinity, 50), // Full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const SizedBox(height: 20), // Spacing from bottom
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
