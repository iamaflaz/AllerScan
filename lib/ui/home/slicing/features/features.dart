import 'package:allerscan/ui/home/slicing/features/article/see_more/article_list.dart';
import 'package:allerscan/ui/home/slicing/features/bmi/count/count_page.dart';
import 'package:allerscan/ui/home/slicing/features/calori/count/count_page.dart';
import 'package:flutter/material.dart';
import 'package:allerscan/ui/home/slicing/features/widgets/feature_card.dart';

class FiturSection extends StatelessWidget {
  const FiturSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FeatureCard(
            title: "BMI",
            assetPath: "assets/icons/bmi.png",
            routeBuilder: BMICountPage(),
          ),
          FeatureCard(
            title: "BMR",
            assetPath: "assets/icons/bmr.png",
            routeBuilder: CaloriCountPage(),
          ),
          FeatureCard(
            title: "Article",
            assetPath: "assets/icons/bmi.png",
            routeBuilder: ArticleListPage(),
          ),
        ],
      ),
    );
  }
}
