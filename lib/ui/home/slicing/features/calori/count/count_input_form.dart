import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';

class CaloriInputForm extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController ageController;
  final String gender;
  final double activityFactor;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<double?> onActivityChanged;
  final VoidCallback onCalculatePressed;

  const CaloriInputForm({
    super.key,
    required this.weightController,
    required this.heightController,
    required this.ageController,
    required this.gender,
    required this.activityFactor,
    required this.onGenderChanged,
    required this.onActivityChanged,
    required this.onCalculatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDropdownGender(),
        const SizedBox(height: 10),
        _buildInputField("Berat Badan (kg)", weightController),
        const SizedBox(height: 10),
        _buildInputField("Tinggi Badan (cm)", heightController),
        const SizedBox(height: 10),
        _buildInputField("Usia", ageController),
        const SizedBox(height: 10),
        _buildActivityDropdown(),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: onCalculatePressed,
            child: Text(
              'Hitung',
              style: AppTextStyles.montsReg1.copyWith(color: colorWhite),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: const TextStyle(color: primaryColor),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorGray1, width: 1),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Widget _buildDropdownGender() {
    return DropdownButtonFormField<String>(
      value: gender,
      decoration: _dropdownDecoration("Jenis Kelamin"),
      items: const [
        DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
        DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
      ],
      onChanged: onGenderChanged,
    );
  }

  Widget _buildActivityDropdown() {
    return DropdownButtonFormField<double>(
      value: activityFactor,
      decoration: _dropdownDecoration("Tingkat Aktivitas"),
      items: const [
        DropdownMenuItem(value: 1.2, child: Text('Sangat sedikit aktivitas')),
        DropdownMenuItem(value: 1.375, child: Text('Ringan (1-3x/minggu)')),
        DropdownMenuItem(value: 1.55, child: Text('Sedang (3-5x/minggu)')),
        DropdownMenuItem(value: 1.725, child: Text('Berat (6-7x/minggu)')),
        DropdownMenuItem(value: 1.9, child: Text('Sangat berat')),
      ],
      onChanged: onActivityChanged,
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      floatingLabelStyle: const TextStyle(color: primaryColor),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorGray1, width: 1),
      ),
      fillColor: Colors.white,
      filled: true,
    );
  }
}
