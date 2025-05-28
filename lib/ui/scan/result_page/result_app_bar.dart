import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';

class ScanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ScanAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      toolbarHeight: 86,
      leading: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: colorWhite,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          'Hasil Scan',
          style: AppTextStyles.poppinsBold2.copyWith(color: colorWhite),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(86);
}
