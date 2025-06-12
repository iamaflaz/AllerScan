import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/article/models.dart';
import 'package:allerscan/ui/home/slicing/features/article/see_more/detail.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

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
            if (article.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(article.imageUrl, width: 90, height: 90, fit: BoxFit.cover),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.title, style: AppTextStyles.montsBold5.copyWith(color: colorBlack)),
                  const SizedBox(height: 4),
                  Text(article.date, style: AppTextStyles.montsReg2.copyWith(color: colorBlack)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
