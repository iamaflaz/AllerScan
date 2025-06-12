import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/article/widget/article_card.dart';
import 'package:allerscan/ui/home/slicing/features/article/models.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '/ui/home/slicing/features/article/service.dart';

class BeritaSection extends StatefulWidget {
  const BeritaSection({super.key});

  @override
  State<BeritaSection> createState() => _BeritaSectionState();
}

class _BeritaSectionState extends State<BeritaSection> {
  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBerita();
  }

  Future<void> fetchBerita() async {
    try {
      final result = await ApiService.fetchArticles();
      setState(() {
        articles = result.take(3).toList();
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('news_section_title'.tr(), style: AppTextStyles.poppinsBold3.copyWith(color: colorBlack)),
          const SizedBox(height: 4),
          Text('news_section_subtitle'.tr(), style: AppTextStyles.montsReg1.copyWith(color: colorBlack)),
          const SizedBox(height: 16),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: articles.map((article) => ArticleCard(article: article)).toList(),
                ),
        ],
      ),
    );
  }
}
