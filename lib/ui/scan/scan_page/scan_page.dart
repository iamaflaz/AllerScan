import 'package:allerscan/ui/scan/result_page/result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:allerscan/ui/scan/scan_page/helpers/image_picker_alert.dart';
import 'package:allerscan/ui/manage/manage_allergies/providers/allergy_provider.dart';
import 'package:allerscan/ui/scan/scan_page/interfaces/text_recognizer.dart';
import 'package:allerscan/ui/scan/scan_page/helpers/mlkit_text_recognizer.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late ImagePicker _picker;
  late ITextRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _recognizer = MLKitTextRecognizer();
  }

  @override
  void dispose() {
    super.dispose();
    if (_recognizer is MLKitTextRecognizer) {
      (_recognizer as MLKitTextRecognizer).dispose();
    }
  }

  Future<String?> obtainImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source);
    return file?.path;
  }

  void processImage(String imgPath) async {
    final recognizedText = await _recognizer.processImage(imgPath);
    final allergyProvider = Provider.of<AllergyProvider>(
      context,
      listen: false,
    );

    final scannedText = recognizedText.toLowerCase();

    final detectedAllergies =
        allergyProvider.selectedAllergies
            .where((allergy) => scannedText.contains(allergy.toLowerCase()))
            .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => ResultPage(
              detectedAllergies: detectedAllergies,
              imgPath: imgPath,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => imagePickAlert(
                  onCameraPressed: () async {
                    final imgPath = await obtainImage(ImageSource.camera);
                    if (imgPath == null) return;
                    processImage(imgPath);
                    Navigator.of(context).pop();
                  },
                  onGalleryPressed: () async {
                    final imgPath = await obtainImage(ImageSource.gallery);
                    if (imgPath == null) return;
                    processImage(imgPath);
                    Navigator.of(context).pop();
                  },
                ),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
