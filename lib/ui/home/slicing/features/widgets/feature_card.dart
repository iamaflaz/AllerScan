import 'package:flutter/material.dart';
import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String assetPath;
  final Widget? routeBuilder;

  const FeatureCard({
    super.key,
    required this.title,
    required this.assetPath,
    this.routeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (routeBuilder != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => routeBuilder!),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.all(18),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colorGray1,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(assetPath, height: 32),
              const SizedBox(height: 4),
              Text(
                title,
                style: AppTextStyles.poppinsBold6.copyWith(color: colorBlack),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
