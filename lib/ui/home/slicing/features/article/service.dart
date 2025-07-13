import 'dart:convert';
import 'package:allerscan/ui/home/slicing/features/article/models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://berita-api-production.up.railway.app/api/articles';

  static Future<List<Article>> fetchArticles(String lang) async {
    final url = Uri.parse('$baseUrl?lang=$lang'); // tambahkan query lang

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat artikel');
    }
  }
}
