import 'package:allerscan/consts/colors.dart';
import 'package:allerscan/consts/fonts.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map article;

  const DetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final imageUrl = article['urlToImage'] ?? '';
    final title = article['title'] ?? 'No Title';
    final published = article['publishedAt'] ?? '';
    final description = article['description'] ?? 'No Description';
    final author = article['author'] ?? 'BBC News';

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          color: colorWhite,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail',
          style: AppTextStyles.poppinsBold2.copyWith(color: colorWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(imageUrl),
              ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(width: 8),
                    Text(author),
                  ],
                ),
                Text(published),
              ],
            ),
            const SizedBox(height: 16),
            Text(description, style: TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
