import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchAllergyWarnings(List<String> allergies) async {
  final apiKey = 'AIzaSyCtAi5Q-_bmGnv5Yjm9UiJG_DAjN2nZ_JE';
  final url = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
  );

  List<String> warnings = [];

  for (String allergy in allergies) {
    final prompt =
        'Posisikan anda adalah seorang dokter spesialis alergi (tidak perlu dituliskan jika anda seorang dokter spesialis alergi), analisa reaksi seseorang yang memiliki alergi terhadap bahan $allergy apabila mereka tetap mengonsumsi produk tersebut dalam bentuk paragraf. Hasil analisa berupa penjelasan singkat tentang bahan alergennya maksimal 50 kata di paragraf pertama, paragraf kedua berisi reaksinya maksimal 100 kata';

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'];
      warnings.add('• $allergy: $text');
    } else {
      warnings.add('• $allergy: Gagal mengambil data dari Gemini');
    }
  }

  return warnings;
}
