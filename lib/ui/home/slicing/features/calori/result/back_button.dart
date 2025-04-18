import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/calori/count/count_page.dart';
import 'package:flutter/material.dart';

class CaloriBackButton extends StatelessWidget {
  const CaloriBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CaloriCountPage()),
          );
        },
        child: Text(
          'Cek Lagi',
          style: AppTextStyles.montsBold5.copyWith(color: colorWhite),
        ),
      ),
    );
  }
}
