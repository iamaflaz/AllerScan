import 'package:flutter/material.dart';

class BMIResultCategory extends StatelessWidget {
  final String category;
  final bool isContentVisible;

  const BMIResultCategory({Key? key, required this.category, required this.isContentVisible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isContentVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 2),
      child: Text(
        ' $category',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
