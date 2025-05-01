import 'package:allerscan/ui/scan/service/alergi_service.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';

class FailurePage extends StatelessWidget {
  final List<String> detectedAllergies;

  const FailurePage({super.key, required this.detectedAllergies});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/danger.png', height: 50),
                SizedBox(width: 10),
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
            SizedBox(height: 24),
            Text(
              'KANDUNGAN PRODUK',
              style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  detectedAllergies
                      .map(
                        (allergy) => Container(
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
                        ),
                      )
                      .toList(),
            ),

            const SizedBox(height: 24),
            Text(
              'PENJELASAN LEBIH LANJUT',
              style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
            ),
            SizedBox(height: 12),
            FutureBuilder<List<AllergyWarning>>(
              future: fetchAllergyWarnings(detectedAllergies),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
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
                                SizedBox(height: 6),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Reaksi: ',
                                        style: AppTextStyles.montsBold6
                                            .copyWith(color: colorBlack),
                                      ),
                                      TextSpan(
                                        text: warning.reaction,
                                        style: AppTextStyles.montsReg2.copyWith(
                                          color: colorBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Penanganan: ',
                                        style: AppTextStyles.montsBold6
                                            .copyWith(color: colorBlack),
                                      ),
                                      TextSpan(
                                        text: warning.treatment,
                                        style: AppTextStyles.montsReg2.copyWith(
                                          color: colorBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Obat: ',
                                        style: AppTextStyles.montsBold6
                                            .copyWith(color: colorBlack),
                                      ),
                                      TextSpan(
                                        text: warning.medicine,
                                        style: AppTextStyles.montsReg2.copyWith(
                                          color: colorBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  );
                } else {
                  return Text('Tidak ada data.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
