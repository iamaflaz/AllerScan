import 'package:allerscan/consts/colors.dart';
import 'package:flutter/material.dart';

class BeritaSection extends StatelessWidget {
  const BeritaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Seputar Berita",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Tetap terinformasi dengan berita terbaru",
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(179, 74, 74, 74),
            ),
          ),
          SizedBox(height: 16),
          NewsItem(
            imagePath: 'assets/images/news1.png',
            title: 'Tips Membaca Label Makanan',
            subtitle: 'Pelajari cara membaca label makanan untuk hindari alergi.',
          ),
          NewsItem(
            imagePath: 'assets/images/news1.png',
            title: 'Inovasi Aplikasi Kesehatan',
            subtitle: 'Aplikasi baru bantu penderita alergi pantau asupan harian.',
          ),
          NewsItem(
            imagePath: 'assets/images/news1.png',
            title: 'Mengenal BMR & BMI',
            subtitle: 'Kenali perbedaan dan manfaat dari BMR dan BMI.',
          ),
        ],
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const NewsItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: colorBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: colorGray1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
