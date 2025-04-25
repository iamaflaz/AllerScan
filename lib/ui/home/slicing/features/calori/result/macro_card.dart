import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';

class CaloriMacroCard extends StatelessWidget {
  final String label;
  final String value;

  const CaloriMacroCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: colorGray1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Text(label, style: AppTextStyles.montsReg2.copyWith(color: colorBlack)),
            const SizedBox(height: 4),
            Text(value, style: AppTextStyles.montsBold5.copyWith(color: colorBlack)),
          ],
        ),
      ),
    );
  }
}
