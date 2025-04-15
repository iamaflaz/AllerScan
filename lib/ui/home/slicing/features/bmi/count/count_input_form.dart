import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';

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
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedGender,
          decoration: _buildInputDecoration('Jenis Kelamin'),
          onChanged: onGenderChanged,
          items: ['Laki-laki', 'Perempuan'].map((String gender) {
            return DropdownMenuItem(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: heightController,
          keyboardType: TextInputType.number,
          decoration: _buildInputDecoration('Tinggi (cm)'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: weightController,
          keyboardType: TextInputType.number,
          decoration: _buildInputDecoration('Berat (kg)'),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: onCalculatePressed,
            child: Text(
              'Cek',
                style: AppTextStyles.montsReg1.copyWith(color: colorWhite),
            ),
          ),
        ),
      ],
    );
  }
}
