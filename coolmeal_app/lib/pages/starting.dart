import 'package:coolmeal/pages/welcome.dart';
import 'package:flutter/material.dart';

class Startingpage extends StatefulWidget {
  const Startingpage({super.key});

  @override
  State<Startingpage> createState() => _StartingpageState();
}

class _StartingpageState extends State<Startingpage> {
  // create flutter function to handle button press
  void handleButtonPress() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Image covering top part of the screen
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30), // Adjust the radius as needed
                bottomRight: Radius.circular(30), // Adjust the radius as needed
              ),
              child: Container(
                height: MediaQuery.of(context).size.height *
                    0.4, // Covering top 40% of the screen height
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/family.png'), // Replace with the correct path to your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Content below the image
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CoolMeal Text and Subtitle
                  const SizedBox(height: 40),

                  Image.asset(
                    'assets/images/Logo.png',
                    height: 150,
                  ),
                  Text(
                    'Ready to Eat Healthy and Feel Great?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green[800],
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Button
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: ElevatedButton(
                onPressed: handleButtonPress,
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
