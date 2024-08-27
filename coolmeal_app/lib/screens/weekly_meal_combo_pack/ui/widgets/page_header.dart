
import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetImagePath;

  const CategoryTitle(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.assetImagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: -1.0,
              ),
            ),
          ],
        )),
        Image.asset(
          assetImagePath,
          width: 120,
          height: 120,
        )
      ],
    );
  }
}
