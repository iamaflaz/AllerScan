import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/calori/count/count_page.dart';
import 'package:allerscan/ui/home/slicing/features/calori/result/macro_section.dart';
import 'package:allerscan/ui/home/slicing/features/calori/result/tips.dart';
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
          'Hasil Kalori Harian',
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
              title: "👨‍⚕️ Hasil BMR Anda",
              value: "${bmr.round()} kcal/hari",
              description:
                  "*BMR adalah jumlah kalori minimum yang dibutuhkan tubuhmu untuk menjalankan fungsi dasar seperti bernapas, menjaga suhu tubuh, dan detak jantung saat kamu tidak melakukan aktivitas apapun (misalnya tidur). Kalori ini penting agar tubuh bisa tetap hidup dan bekerja dengan baik meski tanpa aktivitas fisik.",
            ),
            const SizedBox(height: 16),
            CaloriTipsCard(
              title: "🏃‍♂️ Hasil TDEE Anda",
              value: "${tdee.round()} kcal/hari",
              description:
                  "*TDEE adalah jumlah total kalori yang kamu butuhkan dalam sehari berdasarkan aktivitas fisikmu, mulai dari berjalan, belajar, berolahraga, hingga aktivitas ringan lainnya.Dengan tahu TDEE, kamu bisa menentukan apakah ingin menambah berat badan (surplus kalori), menurunkan berat badan (defisit kalori), atau menjaga berat badan (kalori seimbang).",
            ),
            const SizedBox(height: 24),
            CaloriMacroSection(
              title: "Bulking",
              subtitle:
                  "Bulking dilakukan saat kamu ingin meningkatkan massa otot atau berat badan. Asupan kalori akan lebih tinggi dari kebutuhan harian agar tubuh memiliki cukup energi untuk membentuk otot.",
              macros: bulkingMacros,
            ),
            const SizedBox(height: 24),
            CaloriMacroSection(
              title: "Cutting",
              subtitle:
                  "Cutting dilakukan untuk menurunkan berat badan atau kadar lemak tubuh. Kalori yang dikonsumsi akan dikurangi agar tubuh menggunakan cadangan lemak sebagai sumber energi.",
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
                  "Cek Lagi",
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
                  "Kembali",
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
