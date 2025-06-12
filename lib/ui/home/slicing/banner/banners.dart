import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;
    final imagePath =
        currentLang == 'en'
            ? "assets/images/bannereng.png"
            : "assets/images/banner.png";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
