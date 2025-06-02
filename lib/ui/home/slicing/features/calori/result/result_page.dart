import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/calori/count/count_page.dart';
import 'package:allerscan/ui/home/slicing/features/calori/result/macro_section.dart';
import 'package:allerscan/ui/home/slicing/features/calori/result/tips.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/ui/navbar/navbar.dart';

class CaloriResultPage extends StatelessWidget {
  final double bmr;
  final double tdee;

  const CaloriResultPage({Key? key, required this.bmr, required this.tdee})
    : super(key: key);

  Map<String, dynamic> calculateMacros(double calorieTarget) {
    double carbsCalories = calorieTarget * 0.5;
    double proteinCalories = calorieTarget * 0.3;
    double fatCalories = calorieTarget * 0.2;

    return {
      'protein': (proteinCalories / 4).round(),
      'carbs': (carbsCalories / 4).round(),
      'fat': (fatCalories / 9).round(),
      'total': calorieTarget.round(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final cuttingCalories = tdee * 0.8;
    final bulkingCalories = tdee * 1.2;

    final cuttingMacros = calculateMacros(cuttingCalories);
    final bulkingMacros = calculateMacros(bulkingCalories);

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          color: colorWhite,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'result_calori_title'.tr(),
          style: AppTextStyles.poppinsBold2.copyWith(color: colorWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CaloriTipsCard(
              title: 'result_bmr_title'.tr(),
              value: "${bmr.round()} kcal/day",
              description: 'result_bmr_subtitle'.tr(),
            ),
            const SizedBox(height: 16),
            CaloriTipsCard(
              title: 'result_tdee_title'.tr(),
              value: "${tdee.round()} kcal/day",
              description: 'result_tdee_subtitle'.tr(),
            ),
            const SizedBox(height: 24),
            CaloriMacroSection(
              title: "Bulking",
              subtitle: 'bulking_subtitle'.tr(),
              macros: bulkingMacros,
            ),
            const SizedBox(height: 24),
            CaloriMacroSection(
              title: "Cutting",
              subtitle: 'cutting_subtitle'.tr(),
              macros: cuttingMacros,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CaloriCountPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'button_check_again'.tr(),
                  style: AppTextStyles.montsBold5.copyWith(color: colorWhite),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Navbar()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: primaryColor, width: 2),
                  ),
                ),
                child: Text(
                  'button_back'.tr(),
                  style: AppTextStyles.montsBold5.copyWith(color: primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
