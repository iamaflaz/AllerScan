import 'dart:convert';
import 'package:allerscan/ui/home/slicing/features/article/models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://profound-communication-production.up.railway.app/api/articles';

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat artikel');
    }
  }
}