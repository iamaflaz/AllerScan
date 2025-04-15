import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/count/count_app_bar.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/count/count_input_form.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/result/result_page.dart';
import 'package:flutter/material.dart';

class BMICountPage extends StatefulWidget {
  const BMICountPage({super.key});

  @override
  State<BMICountPage> createState() => _BMICountPageState();
}

class _BMICountPageState extends State<BMICountPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _selectedGender = 'Laki-laki';

  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      final double heightInMeter = height / 100;
      final double bmi = weight / (heightInMeter * heightInMeter);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => BMIResultPage(bmi: bmi, gender: _selectedGender),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Masukkan data yang valid')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const BMICustomAppBar(),
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
              'Yuk, cek BMI-mu!',
              style: AppTextStyles.poppinsBold2.copyWith(color: colorBlack),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Apakah berat badanmu sudah ideal sesuai tinggi badan?',
                style: AppTextStyles.montsReg1.copyWith(color: colorBlack),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            BMIInputForm(
              heightController: _heightController,
              weightController: _weightController,
              selectedGender: _selectedGender,
              onGenderChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              onCalculatePressed: _calculateBMI,
            ),
          ],
        ),
      ),
    );
  }
}