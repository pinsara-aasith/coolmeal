import 'package:coolmeal/pages/GoogleSignInButtonWidget.dart';
import 'package:coolmeal/widgets/LoginButtonWidget%20.dart';
import 'package:flutter/material.dart';
import 'package:coolmeal/widgets/BackButtonWidget.dart';
import 'package:coolmeal/widgets/WelcomeTextWidget.dart';
import 'package:coolmeal/widgets/EmailInputWidget.dart';
import 'package:coolmeal/widgets/PasswordInputWidget.dart';
import 'package:coolmeal/widgets/ForgotPasswordWidget.dart';

import 'package:coolmeal/widgets/SignUpTextWidget.dart';
import 'package:coolmeal/widgets/OrDividerWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButtonWidget(),
              const WelcomeTextWidget(),
              const SizedBox(height: 50),
              EmailInputWidget(controller: _emailController),
              const SizedBox(height: 20),
              PasswordInputWidget(controller: _passwordController),
              const SizedBox(height: 10),
              const ForgotPasswordWidget(),
              const SizedBox(height: 40),
              LoginButtonWidget(formKey: _formKey),
              const SizedBox(height: 20),
              const OrDividerWidget(),
              const SizedBox(height: 20),
              const GoogleSignInButtonWidget(),
              const SizedBox(height: 20),
              const SignUpTextWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
