import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/article/widget/article_card.dart';
import 'package:allerscan/ui/home/slicing/features/article/service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BeritaSection extends StatefulWidget {
  const BeritaSection({super.key});

  @override
  State<BeritaSection> createState() => _BeritaSectionState();
}

class _BeritaSectionState extends State<BeritaSection> {
  List<dynamic> news = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBerita();
  }

  Future<void> fetchBerita() async {
    try {
      final result = await NewsService.fetchNews();
      setState(() {
        news = result.take(3).toList();
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
                  children: news.map((item) {
                    return ArticleCard(
                      imageUrl: item['urlToImage'] ?? '',
                      title: item['title'] ?? '',
                      published: item['publishedAt'] ?? '',
                      article: item,
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
