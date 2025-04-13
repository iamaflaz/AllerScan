import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/count.dart';
import 'package:allerscan/ui/home/slicing/features/bmr/count.dart';
import 'package:flutter/material.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fitur Lainnya',
            style: AppTextStyles.bodyTitle,
          ),
          const SizedBox(height: 5),

          Text(
            'Jelajahi fitur tambahan yang membantu Anda ',
            style: AppTextStyles.bodyCapt,
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _FeatureCard(
                title: 'BMR',
                imagePath: 'assets/icon/bmr.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BmiCountPage()),
                  );
                },
              ),
              _FeatureCard(
                title: 'BMI',
                imagePath: 'assets/icon/bmi.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BmrCountPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(imagePath),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
