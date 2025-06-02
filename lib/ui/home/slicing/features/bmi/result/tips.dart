import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BMITips extends StatelessWidget {
  final String category;

  const BMITips({Key? key, required this.category}) : super(key: key);

Map<String, Map<String, String>> getBMIMessages() {
  return {
    'UNDERWEIGHT': {
      'headline': 'bmi.underweight.headline'.tr(),
      'sub': 'bmi.underweight.sub'.tr(),
    },
    'IDEAL': {
      'headline': 'bmi.ideal.headline'.tr(),
      'sub': 'bmi.ideal.sub'.tr(),
    },
    'OVERWEIGHT': {
      'headline': 'bmi.overweight.headline'.tr(),
      'sub': 'bmi.overweight.sub'.tr(),
    },
    'OBESITAS': {
      'headline': 'bmi.obesitas.headline'.tr(),
      'sub': 'bmi.obesitas.sub'.tr(),
    },
  };
}


  @override
  Widget build(BuildContext context) {
    final message = getBMIMessages()[category]!;
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(seconds: 2),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['headline']!,
                style: AppTextStyles.poppinsBold3.copyWith(color: colorBlack),
            ),
            const SizedBox(height: 8),
            Text(
              message['sub']!,
                style: AppTextStyles.montsReg1.copyWith(color: colorBlack),
            ),
          ],
        ),
      ),
    );
  }
}
