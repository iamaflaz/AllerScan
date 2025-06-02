import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:easy_localization/easy_localization.dart';

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
    final List<String> genderKeys = ['male', 'female'];
    final Map<double, String> activityOptions = {
      1.2: 'activity.very_low',
      1.3: 'activity.light',
      1.55: 'activity.moderate',
      1.73: 'activity.high',
    };

    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: gender,
          decoration: _dropdownDecoration('gender_title'.tr()),
          items: genderKeys.map((key) {
            return DropdownMenuItem(
              value: key,
              child: Text('gender.$key'.tr()),
            );
          }).toList(),
          onChanged: onGenderChanged,
        ),
        const SizedBox(height: 10),
        _buildInputField('weight_title'.tr(), weightController),
        const SizedBox(height: 10),
        _buildInputField('height_title'.tr(), heightController),
        const SizedBox(height: 10),
        _buildInputField('ages_title'.tr(), ageController),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DropdownButtonFormField<double>(
                value: activityFactor,
                decoration: _dropdownDecoration('activity_title'.tr()),
                items: activityOptions.entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.value.tr()),
                  );
                }).toList(),
                onChanged: onActivityChanged,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.help_outline, color: primaryColor),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: colorWhite,
                    title: Text(
                      'activity_explanation_title'.tr(),
                      style: AppTextStyles.poppinsBold4.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildActivityExplanation(
                            context,
                            'activity.explanation.very_low_title'.tr(),
                            'activity.explanation.very_low_desc'.tr(),
                          ),
                          _buildActivityExplanation(
                            context,
                            'activity.explanation.light_title'.tr(),
                            'activity.explanation.light_desc'.tr(),
                          ),
                          _buildActivityExplanation(
                            context,
                            'activity.explanation.moderate_title'.tr(),
                            'activity.explanation.moderate_desc'.tr(),
                          ),
                          _buildActivityExplanation(
                            context,
                            'activity.explanation.high_title'.tr(),
                            'activity.explanation.high_desc'.tr(),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'button_close'.tr(),
                          style: AppTextStyles.montsReg2.copyWith(
                            color: colorBlack,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
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
  Widget _buildActivityExplanation(BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: AppTextStyles.poppinsBold6.copyWith(color: colorBlack),
            ),
            TextSpan(
              text: description,
              style: AppTextStyles.montsReg2.copyWith(color: colorBlack),
            ),
          ],
        ),
      ),
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
