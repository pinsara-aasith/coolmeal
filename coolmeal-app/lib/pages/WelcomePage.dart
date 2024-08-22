import 'package:coolmeal/pages/LoginPage.dart';
import 'package:coolmeal/pages/SignUpPage.dart';
import 'package:flutter/material.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  // Add method to handle Sign Up
  void handleSignUp() {
    // Navigate to Sign Up page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  //add method to handle Login
  void handleLogin() {
    // Navigate to Login page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Top Logo and Welcome Text
                  const SizedBox(height: 60), // Spacing from top
                  Image.asset(
                    'assets/images/Logo.png', // Replace with your logo image
                    height: 60,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome Aboard!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Join Us and Start Your Journey to Healthier Meals!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              // Illustration Image
              Image.asset(
                'assets/images/conversation.png', // Replace with your illustration image
                height: 300,
              ),

              // Sign Up and Login Buttons
              Column(
                children: [
                  ElevatedButton(
                    onPressed: handleSignUp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.green,
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: handleLogin,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(color: Colors.green, width: 2),
                      minimumSize:
                          const Size(double.infinity, 50), // Full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Spacing from bottom
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
