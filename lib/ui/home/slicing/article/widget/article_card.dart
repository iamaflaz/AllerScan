import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/article/see_more/detail.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String published;
  final Map article;

  const ArticleCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.published,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(article: article)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, width: 90, height: 90, fit: BoxFit.cover),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.montsBold5.copyWith(color: colorBlack)),
                  const SizedBox(height: 4),
                  Text(published, style: AppTextStyles.montsReg2.copyWith(color: colorBlack)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
