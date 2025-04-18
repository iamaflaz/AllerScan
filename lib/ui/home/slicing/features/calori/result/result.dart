import 'package:flutter/material.dart';

class CaloriResultPage extends StatelessWidget {
  final double bmr;
  final double tdee;

  const CaloriResultPage({
    Key? key,
    required this.bmr,
    required this.tdee,
  }) : super(key: key);

  Map<String, dynamic> calculateMacros(double calorieTarget) {
    double carbsCalories = calorieTarget * 0.5;
    double proteinCalories = calorieTarget * 0.3;
    double fatCalories = calorieTarget * 0.2;

    return {
      'protein': (proteinCalories / 4).round(), // gram
      'carbs': (carbsCalories / 4).round(),
      'fat': (fatCalories / 9).round(),
      'total': calorieTarget.round()
    };
  }

  @override
  Widget build(BuildContext context) {
    final cuttingCalories = tdee * 0.8;
    final bulkingCalories = tdee * 1.2;

    final cuttingMacros = calculateMacros(cuttingCalories);
    final bulkingMacros = calculateMacros(bulkingCalories);

    return Scaffold(
      appBar: AppBar(title: const Text("Hasil Perhitungan")),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              "BMR Anda: ${bmr.toStringAsFixed(2)} kcal",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              "TDEE Anda: ${tdee.toStringAsFixed(2)} kcal",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
            const Text(
              "Saran Cutting (Defisit 20%):",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Kalori Harian: ${cuttingMacros['total']} kcal"),
            Text("Protein: ${cuttingMacros['protein']}g"),
            Text("Karbohidrat: ${cuttingMacros['carbs']}g"),
            Text("Lemak: ${cuttingMacros['fat']}g"),
            const SizedBox(height: 30),
            const Text(
              "Saran Bulking (Surplus 20%):",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Kalori Harian: ${bulkingMacros['total']} kcal"),
            Text("Protein: ${bulkingMacros['protein']}g"),
            Text("Karbohidrat: ${bulkingMacros['carbs']}g"),
            Text("Lemak: ${bulkingMacros['fat']}g"),
          ],
        ),
      ),
    );
  }
}
