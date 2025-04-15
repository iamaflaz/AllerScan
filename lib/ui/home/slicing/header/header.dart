import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            color: secondaryColor,
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
            height: 370,
            width: size.width,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -68,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fitur Lainnya",
                style: AppTextStyles.poppinsBold3.copyWith(color: colorBlack),
              ),
              SizedBox(height: 4),
              Text(
                "Jelajahi fitur tambahan yang membantu Anda",
                style: AppTextStyles.montsReg1.copyWith(color: colorBlack),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
