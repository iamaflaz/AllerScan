import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/calori/result/macro_card.dart';
import 'package:flutter/material.dart';

class CaloriMacroSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Map<String, dynamic> macros;

  const CaloriMacroSection({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.macros,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.montsBold5.copyWith(color: colorBlack)),
        const SizedBox(height: 8),
        Text(subtitle, style: AppTextStyles.montsReg3.copyWith(color: colorGray1)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CaloriMacroCard(label: "Karbohidrat", value: "${macros['carbs']}gram/hari"),
            CaloriMacroCard(label: "Protein", value: "${macros['protein']}gram/hari"),
            CaloriMacroCard(label: "Lemak", value: "${macros['fat']}gram/hari"),
          ],
        ),
      ],
    );
  }
}
