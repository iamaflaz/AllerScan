import 'dart:convert';
import 'package:http/http.dart' as http;

class AllergyWarning {
  final String allergy;
  final String reaction;
  final String treatment;
  final String medicine;

  AllergyWarning({
    required this.allergy,
    required this.reaction,
    required this.treatment,
    required this.medicine,
  });
}

Future<List<AllergyWarning>> fetchAllergyWarnings(
  List<String> allergies,
  String localeCode,  // misal 'id' atau 'en'
) async {
  final apiKey = 'AIzaSyCtAi5Q-_bmGnv5Yjm9UiJG_DAjN2nZ_JE';
  final url = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
  );

  List<AllergyWarning> warnings = [];

  // Buat map prompt per bahasa, contoh:
  final prompts = {
    'id': '''Analisis alergi terhadap bahan "\$allergy". Tolong jawab dengan format persis seperti ini:
Reaksi: ...
Penanganan: ...
Obat: ...
Batasi masing-masing poin maksimal 50 kata. Jangan gunakan bullet.''',
    'en': '''Analyze allergy for ingredient "\$allergy". Please answer exactly in this format:
Reaction: ...
Treatment: ...
Medicine: ...
Limit each point to maximum 50 words. Do not use bullet points.''',
  };

  for (String allergy in allergies) {
    final prompt = prompts[localeCode]?.replaceAll('\$allergy', allergy) ??
        prompts['en']!.replaceAll('\$allergy', allergy);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['candidates'][0]['content']['parts'][0]['text'] ?? '';

      final reactionMatch = RegExp(
        r'(Reaksi|Reaction)\s*:\s*(.+)',
        caseSensitive: false,
      ).firstMatch(text);
      final treatmentMatch = RegExp(
        r'(Penanganan|Treatment)\s*:\s*(.+)',
        caseSensitive: false,
      ).firstMatch(text);
      final medicineMatch = RegExp(
        r'(Obat|Medicine)\s*:\s*(.+)',
        caseSensitive: false,
      ).firstMatch(text);

      final reaction = reactionMatch?.group(2)?.trim() ?? 'Tidak ditemukan';
      final treatment = treatmentMatch?.group(2)?.trim() ?? 'Tidak ditemukan';
      final medicine = medicineMatch?.group(2)?.trim() ?? 'Tidak ditemukan';

      warnings.add(
        AllergyWarning(
          allergy: allergy,
          reaction: reaction,
          treatment: treatment,
          medicine: medicine,
        ),
      );
    } else {
      warnings.add(
        AllergyWarning(
          allergy: allergy,
          reaction: 'Gagal mengambil data',
          treatment: '-',
          medicine: '-',
        ),
      );
    }
  }

  return warnings;
}

