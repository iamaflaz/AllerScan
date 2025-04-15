import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/count/count_page.dart';
import 'package:flutter/material.dart';

class BMIBackButton extends StatelessWidget {
  const BMIBackButton({Key? key}) : super(key: key);

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
            MaterialPageRoute(builder: (context) => BMICountPage()),
          );
        },
        child: Text(
          'Cek Lagi',
          style: AppTextStyles.montsReg1.copyWith(color: colorWhite),
        ),
      ),
    );
  }
}
