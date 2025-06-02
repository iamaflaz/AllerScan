import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/article/see_more/article_list.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/count/count_page.dart';
import 'package:allerscan/ui/home/slicing/features/calori/count/count_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:allerscan/ui/home/slicing/features/widgets/feature_card.dart';

class FiturSection extends StatelessWidget {
  const FiturSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'features_section_title'.tr(),
            style: AppTextStyles.poppinsBold3.copyWith(color: colorBlack),
          ),
          const SizedBox(height: 5),
          Text(
            'features_section_subtitle'.tr(),
            style: AppTextStyles.montsReg1.copyWith(color: colorBlack),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FeatureCard(
                title: "BMI",
                assetPath: "assets/icons/bmi.png",
                routeBuilder: BMICountPage(),
              ),
              FeatureCard(
                title: 'calories_count_app_bar'.tr(),
                assetPath: "assets/icons/bmr.png",
                routeBuilder: CaloriCountPage(),
              ),
              FeatureCard(
                title: "Article",
                assetPath: "assets/icons/article.png",
                routeBuilder: ArticleListPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
