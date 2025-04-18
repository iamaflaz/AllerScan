// lib/services/news_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const _apiKey = '943bf8ebff0240ba8b4792c215f7b916';
  static const _apiUrl = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$_apiKey';

  static Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
