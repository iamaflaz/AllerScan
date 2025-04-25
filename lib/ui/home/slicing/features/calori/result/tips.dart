import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';

class CaloriTipsCard extends StatelessWidget {
  final String title;
  final String value;
  final String description;

  const CaloriTipsCard({
    Key? key,
    required this.title,
    required this.value,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorGray2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.montsBold5.copyWith(color: colorBlack)),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.poppinsBold1.copyWith(color: primaryColor)),
          const SizedBox(height: 8),
          Text(description, style: AppTextStyles.montsReg2.copyWith(color: colorGray1)),
        ],
      ),
    );
  }
}
