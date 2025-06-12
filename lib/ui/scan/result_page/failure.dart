import 'package:allerscan/ui/scan/service/alergi_service.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vibration/vibration.dart';

class FailurePage extends StatelessWidget {
  final List<String> detectedAllergies;

  const FailurePage({super.key, required this.detectedAllergies});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(pattern: [0, 400, 300, 400]);
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/danger.png', height: 50),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'allergy_detected_title'.tr(),
                      style: AppTextStyles.poppinsBold4.copyWith(
                        color: colorRed1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'allergy_detected_desc'.tr(),
                      style: AppTextStyles.montsReg2.copyWith(
                        color: colorBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'product_content'.tr(),
            style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                detectedAllergies.map((allergy) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: colorRed2,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      allergy,
                      style: AppTextStyles.montsBold6.copyWith(
                        color: colorRed1,
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'further_explanation'.tr(),
            style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<AllergyWarning>>(
            future: fetchAllergyWarnings(
              detectedAllergies,
              context.locale.languageCode,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return _buildGeneralErrorUI(context, snapshot.error.toString());
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Text('no_data'.tr());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      snapshot.data!.map((warning) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '• ${warning.allergy}',
                                style: AppTextStyles.poppinsBold5.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              _buildRichText(
                                context,
                                'reaction'.tr(),
                                warning.reaction,
                              ),
                              _buildRichText(
                                context,
                                'treatment'.tr(),
                                warning.treatment,
                              ),
                              _buildRichText(
                                context,
                                'medicine'.tr(),
                                warning.medicine,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                );
              } else {
                return Text('no_data'.tr());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRichText(BuildContext context, String label, String content) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: AppTextStyles.montsBold6.copyWith(color: colorBlack),
          ),
          TextSpan(
            text: content,
            style: AppTextStyles.montsReg2.copyWith(color: colorBlack),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralErrorUI(BuildContext context, String errorMessage) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/images/no_internet.png', height: 150),
          const SizedBox(height: 12),
          Text(
            'Tidak ada koneksi internet'.tr(),
            style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Silakan periksa koneksi Anda dan coba lagi'.tr(),
            style: AppTextStyles.montsReg2.copyWith(color: colorBlack),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
