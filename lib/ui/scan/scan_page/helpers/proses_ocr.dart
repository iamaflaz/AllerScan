import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'image_picker_alert.dart';
import '../interfaces/text_recognizer.dart';
import 'mlkit_text_recognizer.dart';
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart';
import 'package:allerscan/ui/scan/result_page/result_page.dart';

class OCRHelper {
  final BuildContext context;
  final ImagePicker _picker = ImagePicker();
  final ITextRecognizer _recognizer = MLKitTextRecognizer();

  OCRHelper(this.context);

  void dispose() {
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
  }

  void pickAndProcessImage() {
    showDialog(
      context: context,
      builder:
          (context) => imagePickAlert(
            onCameraPressed: () async {
              final imgPath = await _picker.pickImage(
                source: ImageSource.camera,
              );
              if (imgPath == null) return;
              processImage(imgPath.path);
              Navigator.of(context).pop();
            },
            onGalleryPressed: () async {
              final imgPath = await _picker.pickImage(
                source: ImageSource.gallery,
              );
              if (imgPath == null) return;
              processImage(imgPath.path);
              Navigator.of(context).pop();
            },
          ),
    );
  }

  void processImage(String imgPath) async {
    final recognizedText = await _recognizer.processImage(imgPath);

    if (recognizedText.trim().isEmpty) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Allergi tidak ditemukan'),
              content: const Text('Tolong arahkan kamera ke label makanan'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      return;
    }

    final allergyProvider = Provider.of<AllergyProvider>(
      context,
      listen: false,
    );

    final detectedAllergies = allergyProvider.getDetectedAllergens(
      recognizedText,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ResultPage(
          detectedAllergies: detectedAllergies,
          imgPath: imgPath,
        );
      },
    );
  }
}
