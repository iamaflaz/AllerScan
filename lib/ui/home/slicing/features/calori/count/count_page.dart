import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/calori/count/count_app_bar.dart';
import 'package:allerscan/ui/home/slicing/features/calori/count/count_input_form.dart';
import 'package:allerscan/ui/home/slicing/features/calori/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class CaloriCountPage extends StatefulWidget {
  const CaloriCountPage({super.key});

  @override
  State<CaloriCountPage> createState() => _CaloriCountPageState();
}

class _CaloriCountPageState extends State<CaloriCountPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String gender = 'male'; // default key
  double activityFactor = 1.2;

  void calculateCalori() {
    final double weight = double.tryParse(weightController.text) ?? 0;
    final double height = double.tryParse(heightController.text) ?? 0;
    final int age = int.tryParse(ageController.text) ?? 0;

    if (weight > 0 && height > 0 && age > 0) {
      double bmr = 0.0;
      if (gender == 'male') {
        bmr = 13.7 * weight + 5 * height - 6.8 * age + 65;
      } else {
        bmr = 9.6 * weight + 1.8 * height - 4.7 * age + 655;
      }

      double tdee = bmr * activityFactor;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CaloriResultPage(bmr: bmr, tdee: tdee),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('validation'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const CaloriCustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/bmi_1.png',
                width: 240,
                height: 240,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'count_calori_title'.tr(),
              style: AppTextStyles.poppinsBold2.copyWith(color: colorBlack),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'count_calori_subtitle'.tr(),
                style: AppTextStyles.montsReg1.copyWith(color: colorBlack),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            CaloriInputForm(
              weightController: weightController,
              heightController: heightController,
              ageController: ageController,
              gender: gender,
              activityFactor: activityFactor,
              onGenderChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
              onActivityChanged: (value) {
                setState(() {
                  activityFactor = value!;
                });
              },
              onCalculatePressed: calculateCalori,
            ),
          ],
        ),
      ),
    );
  }
}
