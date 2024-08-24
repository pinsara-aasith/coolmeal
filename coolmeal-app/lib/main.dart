import 'package:coolmeal/pages/CompleteProfilePage.dart';
import 'package:coolmeal/pages/LoadingPage.dart';
import 'package:coolmeal/pages/LoginPage.dart';
import 'package:coolmeal/pages/SignUpPage.dart';
import 'package:coolmeal/pages/StartingPage.dart';
import 'package:coolmeal/pages/WelcomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Meal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CompleteProfilePage(),
    );
  }
}
