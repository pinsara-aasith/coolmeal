import 'package:flutter/material.dart';

class Startingpage extends StatefulWidget {
  const Startingpage({super.key});

  @override
  State<Startingpage> createState() => _StartingpageState();
}

class _StartingpageState extends State<Startingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top Image
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/family_meal.jpeg', // Replace with the correct path to your image
                      height: 200, // Adjust the height as needed
                    ),
                  ),
                  // CoolMeal Text and Subtitle
                  Text(
                    'COOLMEAL',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  Text(
                    'Ready to Eat Healthy and Feel Great?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[600],
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Button
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Let's Start",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
