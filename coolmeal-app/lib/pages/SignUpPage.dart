import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Form state and controllers----
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Password validation state and password requirements----

  bool _isPasswordVisible = false;
  bool _hasSpecialCharacter = false;
  bool _hasNumber = false;
  bool _hasUpperCase = false;
  bool _isPasswordLengthValid = false;

  void _validatePassword(String value) {
    setState(() {
      _hasSpecialCharacter = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      _hasNumber = value.contains(RegExp(r'\d'));
      _hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      _isPasswordLengthValid = value.length >= 8 && value.length <= 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create New Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create New Account and Begin Your Healthy Eating Journey',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Validate Email using RegExp ------------
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      _validatePassword(value!);
                      if (!_hasSpecialCharacter ||
                          !_hasNumber ||
                          !_hasUpperCase ||
                          !_isPasswordLengthValid) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _validatePassword(value);
                    },
                  ),
                  const SizedBox(height: 16),
                  PasswordRequirements(
                    hasSpecialCharacter: _hasSpecialCharacter,
                    hasNumber: _hasNumber,
                    hasUpperCase: _hasUpperCase,
                    isPasswordLengthValid: _isPasswordLengthValid,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform sign up logic
                      }
                    },
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('or', style: TextStyle(color: Colors.grey[700])),
                  SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Image.asset('assets/images/google.png', height: 24),
                    label: Text('Sign up with Google'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[700]),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordRequirements extends StatelessWidget {
  final bool hasSpecialCharacter;
  final bool hasNumber;
  final bool hasUpperCase;
  final bool isPasswordLengthValid;

  PasswordRequirements({
    required this.hasSpecialCharacter,
    required this.hasNumber,
    required this.hasUpperCase,
    required this.isPasswordLengthValid,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your password should contain'),
        SizedBox(height: 8),
        RequirementItem(
          text: '1 or more special characters',
          isValid: hasSpecialCharacter,
        ),
        RequirementItem(
          text: '1 or more numbers',
          isValid: hasNumber,
        ),
        RequirementItem(
          text: '1 upper case letter',
          isValid: hasUpperCase,
        ),
        RequirementItem(
          text: 'Between 8 and 20 characters',
          isValid: isPasswordLengthValid,
        ),
      ],
    );
  }
}

class RequirementItem extends StatelessWidget {
  final String text;
  final bool isValid;

  RequirementItem({required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: isValid ? Colors.green : Colors.grey,
          size: 20,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
