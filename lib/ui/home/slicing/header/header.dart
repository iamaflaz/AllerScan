import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 200, color: secondaryColor),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(child: Text('AllerScan', style: AppTextStyles.title2)),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset('assets/maskot/body.png', height: 150),
        ),

        Positioned.fill(
          top: 180,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
          ),
        ),

        Positioned(
          top: 165,
          left: 0,
          right: 0,
          child: Image.asset('assets/maskot/hand.png', height: 25),
        ),
      ],
    );
  }
}
