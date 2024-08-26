import 'package:flutter/material.dart';

class UnifiedBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UnifiedBackButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.lightGreen,
          width: 1,
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}
