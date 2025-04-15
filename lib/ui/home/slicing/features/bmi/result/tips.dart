import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';

class BMITips extends StatelessWidget {
  final String category;

  const BMITips({Key? key, required this.category}) : super(key: key);

  Map<String, Map<String, String>> getBMIMessages() {
    return {
      'UNDERWEIGHT': {
        'headline': '📢 Berat badanmu di bawah normal 😕',
        'sub': 'Ayo jaga pola makan dan tambah asupan nutrisi, biar tubuh tetap kuat dan sehat ya!',
      },
      'IDEAL': {
        'headline': '📢 Yeay! Berat badanmu ideal 😄',
        'sub': 'Pertahankan pola makan seimbang dan gaya hidup sehat ya!',
      },
      'OVERWEIGHT': {
        'headline': '📢 Kamu sedikit kelebihan berat badan!',
        'sub': 'Yuk, mulai lebih aktif bergerak dan atur pola makan biar kembali ideal!',
      },
      'OBESITAS': {
        'headline': '📢 Berat badanmu termasuk obesitas 😟',
        'sub': 'Konsultasi ke ahli gizi bisa membantu, yuk mulai dari langkah kecil yang konsisten 💪',
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final message = getBMIMessages()[category]!;
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(seconds: 2),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['headline']!,
                style: AppTextStyles.poppinsBold3.copyWith(color: colorBlack),
            ),
            const SizedBox(height: 8),
            Text(
              message['sub']!,
                style: AppTextStyles.montsReg1.copyWith(color: colorBlack),
            ),
          ],
        ),
      ),
    );
  }
}
