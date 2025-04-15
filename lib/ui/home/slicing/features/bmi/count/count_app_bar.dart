import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';

class BMICustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BMICustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: colorWhite,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Body Mass Index',
        style: AppTextStyles.poppinsBold1.copyWith(color: colorWhite),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
