import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:allerscan/ui/scan/scan_page/interfaces/text_recognizer.dart'; // Import Interface

class MLKitTextRecognizer extends ITextRecognizer {
  late final TextRecognizer _recognizer;

  MLKitTextRecognizer() {
    _recognizer = TextRecognizer();
  }

  void dispose() {
    _recognizer.close();
  }

  @override
  Future<String> processImage(String imgPath) async {
    final image = InputImage.fromFile(File(imgPath));
    final recognized = await _recognizer.processImage(image);
    return recognized.text;
  }
}
