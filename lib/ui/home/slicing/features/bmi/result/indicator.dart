import 'package:allerscan/consts/colors.dart';
import 'package:flutter/material.dart';

class BMIIndicator extends StatelessWidget {
  final double bmi;
  final double indicatorPosition;

  const BMIIndicator({Key? key, required this.bmi, required this.indicatorPosition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'BMI-mu adalah:',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: bmi),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            );
          },
        ),
        SizedBox(height: 24),
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [
                    Colors.green,
                    Colors.yellow,
                    primaryColor,
                    Colors.red,
                  ],
                ),
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0.0,
                end: MediaQuery.of(context).size.width * 0.9 * indicatorPosition,
              ),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Positioned(
                  left: value,
                  top: 0,
                  child: Container(
                    color: Colors.transparent,
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 36,
                      color: colorBlack,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
