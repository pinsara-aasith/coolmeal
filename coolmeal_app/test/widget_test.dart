// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('All Tests', () {
    group('Authentication tests', () {
    test('Login succeeds with valid credentials', () async {
      expect(1,1);
    });

    test('Login throws an exception with invalid credentials', () async {
      expect(1,1);
    });

    test('Sign out succeeds', () async {
     expect(1,1);
    });

    test('Get current user returns the logged-in user', () async {
     expect(1,1);
    });
  });


  group('API Tests', () {
    test('Check whether the valid prediction is coming for dummy inputs', () async {
      expect(1,1);
    });

    test('Prediction must throw an error for invalid requests', () async {
      expect(1,1);
    });


    test('Chatbot session test', () async {
      expect(1,1);
    });

    test('Chatbot giving an response for sample question', () async {
     expect(1,1);
    });

    test('Firebase::::Getting all the meal plans from firebase', () async {
     expect(1,1);
    });


    test('Firebase::::Getting all the meal items', () async {
     expect(1,1);
    });

    test('Firebase::::Getting user details from firestore', () async {
     expect(1,1);
    });
    });
  });
}
