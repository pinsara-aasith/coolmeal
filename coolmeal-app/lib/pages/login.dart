import 'package:coolmeal/pages/google_sign_in_button_widget.dart';
import 'package:coolmeal/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:coolmeal/widgets/back_button.dart';
import 'package:coolmeal/widgets/welcome_text.dart';
import 'package:coolmeal/widgets/email_input.dart';
import 'package:coolmeal/widgets/password_input.dart';
import 'package:coolmeal/widgets/forgot_password.dart';

import 'package:coolmeal/widgets/sign_up_text.dart';
import 'package:coolmeal/widgets/or_divider.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
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
      ),
    );
  }
}
