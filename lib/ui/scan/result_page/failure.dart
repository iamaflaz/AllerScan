import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';

class FailurePage extends StatelessWidget {
  final List<String> detectedAllergies;

  const FailurePage({super.key, required this.detectedAllergies});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ), 
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
                        'Kandungan Alergen Terdeteksi !',
                        style: AppTextStyles.poppinsBold4.copyWith(
                          color: colorRed1,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Produk ini mengandung bahan yang dapat memicu alergi. Sebaiknya hindari konsumsi',
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
              'KANDUNGAN PRODUK',
              style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
            ),
            const SizedBox(height: 12),
            ...detectedAllergies.map(
              (allergy) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: colorRed2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  allergy,
                  style: AppTextStyles.montsBold6.copyWith(color: colorRed1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
