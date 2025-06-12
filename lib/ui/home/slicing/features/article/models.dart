class Article {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final String date;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      date: json['date'],
    );
  }
}