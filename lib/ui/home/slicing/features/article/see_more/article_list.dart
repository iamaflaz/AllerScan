import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:allerscan/ui/home/slicing/features/article/models.dart';
import 'package:allerscan/ui/home/slicing/features/article/see_more/detail.dart';
import 'package:allerscan/ui/home/slicing/features/article/service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadNews();
  }

  Future<void> loadNews() async {
    try {
      final lang = context.locale.languageCode; 
      final result = await ApiService.fetchArticles(
        lang,
      ); 
      setState(() {
        articles = result;
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
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          color: colorWhite,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'news_section_title'.tr(),
          style: AppTextStyles.poppinsBold2.copyWith(color: colorWhite),
        ),
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(article: article),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(blurRadius: 4, color: Colors.black12),
                        ],
                      ),
                      child: Column(
                        children: [
                          if (article.imageUrl.isNotEmpty)
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                article.imageUrl,
                                errorBuilder: (_, __, ___) => const SizedBox(),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article.date,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  article.content,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
