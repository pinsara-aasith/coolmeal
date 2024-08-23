import 'package:coolmeal/pages/loading.dart';
import 'package:coolmeal/pages/login.dart';
import 'package:coolmeal/pages/signup.dart';
import 'package:coolmeal/pages/starting.dart';
import 'package:coolmeal/pages/welcome.dart';
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
      home: const LoadingPage(),
    );
  }
}
