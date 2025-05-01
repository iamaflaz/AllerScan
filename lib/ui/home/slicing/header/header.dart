import 'package:allerscan/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderSection extends StatelessWidget {
  final Size size;

  const HeaderSection({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: size.height * 0.2 - 2,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 195, 116),
          ),
        ),
        Positioned(
          bottom: -100,
          left: 0,
          right: 40,
          child: Image.asset(
            "assets/images/bacck.png",
            height: 250,
            width: size.width,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          bottom: -190,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            "assets/images/kacang.svg",
            height: 365,
            width: size.width,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
