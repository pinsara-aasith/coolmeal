import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';

class LetsStartPage extends StatefulWidget {
  const LetsStartPage({super.key});

  @override
  State<LetsStartPage> createState() => _LetsStartpageState();
}

class _LetsStartpageState extends State<LetsStartPage> {
  void handleLetsStart() {
    Navigator.pushNamed(context, Routes.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: welcomeGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/familyeating.png'),
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 40),
                          Image.asset(
                            'assets/images/Logo.png',
                            height: 200,
                          ),
                          const SizedBox(height:30),
                          Text(
                            'Ready to Eat Healthy and Feel Great?',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: handleLetsStart,
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
                              'Lets Start',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    ])),
          ],
        ),
      ),
    );
  }
}
