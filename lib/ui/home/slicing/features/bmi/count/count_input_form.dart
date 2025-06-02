import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class BMIInputForm extends StatelessWidget {
  final TextEditingController heightController;
  final TextEditingController weightController;
  final String selectedGender;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onCalculatePressed;

  const BMIInputForm({
    Key? key,
    required this.heightController,
    required this.weightController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.onCalculatePressed,
  }) : super(key: key);

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: colorGray1),
      floatingLabelStyle: const TextStyle(color: primaryColor),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorGray1, width: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genderKeys = ['male', 'female'];

    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedGender,
          decoration: _buildInputDecoration('gender_title'.tr(),),
          onChanged: onGenderChanged,
          items:
              genderKeys.map((key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text('gender.$key'.tr()),
                );
              }).toList(),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: heightController,
          keyboardType: TextInputType.number,
          decoration: _buildInputDecoration('height_title'.tr(),),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: weightController,
          keyboardType: TextInputType.number,
          decoration: _buildInputDecoration('weight_title'.tr(),),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: onCalculatePressed,
            child: Text(
              'button_check'.tr(),
              style: AppTextStyles.montsBold5.copyWith(color: colorWhite),
            ),
          ),
        ),
      ],
    );
  }
}
